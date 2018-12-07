#Classe de gerenciamento e controle das reservas de salas da controladora do sistema.
class AppointmentsController < ApplicationController

  def new
    @appointment = Appointment.new
    self.room
  end

  def room
    @room = Room.find(params[:id])
  end

  def appointment
    @appointment = Appointment.find(params[:id])
  end

  def create
    room_id = params[:format]
    self.set_appointment
    if (self.is_reserved?)
    	@appointment.status = 1
      self.appointment_do
      flash[:notice] = "Sua reserva foi solicitada a um administrador pois a sala já está reservada"
    else
    	@appointment.status = 2
      self.appointment_do
		  flash[:notice] = "Reserva realizada com sucesso!"
		end
  end

  #Método que verifica se as entradas de um reserva são válidas e, caso sejam, salva a reserva no banco de dados
  def appointment_do
  	if (params[:appointment_date].size > 0) and (params[:start_time].size > 0) and @appointment.save
  		redirect_to backoffice_path
  	else
  		redirect_to backoffice_path
  		flash[:danger] = "Algo deu errado!"
  	end
  end

  #Método que inicializa as variáveis de uma reserva que está sendo criada
  def set_appointment
  	@appointment = Appointment.new
  	@appointment.room_id = params[:format]
    @appointment.user_id = current_user.id
    @appointment.appointment_date = params[:appointment_date]
    @appointment.start_time = params[:start_time]
  end

  #Método que retorna uma flag indicando se a sala já está reservada em um determinado dia e horário
  def is_reserved?
  	return Appointment.all.where('room_id = ? AND appointment_date = ? AND start_time = ?', @appointment.room_id, @appointment.appointment_date, @appointment.start_time).count != 0 
  end

  def show
    self.room
    @appointments = Appointment.where('appointment_date >= ? AND room_id = ?', Date.today.beginning_of_week, params[:id]).all
    @dates = (Date.today.beginning_of_week..Date.today.beginning_of_week+6).map{ |date| date.strftime("%a (%d/%b)") }
  end

  def edit
    self.appointment
    $status_old = @appointment.status
  end

  # Quando o status da reserva for atualizado, envia um email de notificação
  def update
    self.appointment
    if @appointment.update(appointment_params)
      redirect_to all_appointments_path
      flash.now[:notice] = "A reserva foi editada com sucesso!"
    else
      flash.now[:danger] = "A reserva não pôde ser editada! Tente novamente!"
      render 'edit'
    end
    send_notification
  end

  def my_appointments
    @user = current_user
    @my_appointments = @user.appointments
  end

  def all_appointments
    @appointments = Appointment.all
  end

  #Método que busca as salas com reservas entre o início da semana atual até o fim da semana.
  def weeks_appointments
    if is_admin?
    @weeks_appointments =  Appointment.where('appointment_date BETWEEN ? AND ?',
                                             Date.today.beginning_of_week,
                                             Date.today.end_of_week).sort_by &:appointment_date
    else
      return redirect_to '/'
    end
  end

  def destroy
    self.appointment
    @appointment.destroy
    flash[:danger] = "A reserva foi cancelada com sucesso"
    redirect_to my_appointments_path
  end

  def is_admin?
    if current_user.is_admin
      true
    else
      flash[:danger] = "Você não pode acessar essa página"
      return redirect_to '/'
    end
  end


  private

  def appointment_params
    params.require(:appointment).permit(:status)
  end

  # Send notification to the user
  def send_notification
    if $status_old != @appointment.status
      @appointment.send_status_notification_email
      flash[:info] = "Email enviado ao usuário com status de sua reserva."
    end
  end
end