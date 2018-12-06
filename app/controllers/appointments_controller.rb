#Classe de gerenciamento e controle das reservas de salas da controladora do sistema.
class AppointmentsController < ApplicationController

  def new
    @appointment = Appointment.new
    @room = Room.find(params[:id])
  end

  def create
    room_id = params[:format]
    @appointment = Appointment.new
    @appointment.room_id = params[:format]
    @appointment.user_id = current_user.id
    @appointment.appointment_date = params[:appointment_date]
    @appointment.start_time = params[:start_time]
    @reservado = 0

    Appointment.all.each do |existingappointment|
    	if(@appointment.room_id == existingappointment.room_id) and (@appointment.appointment_date == existingappointment.appointment_date) and (@appointment.start_time == existingappointment.start_time)
      	@reservado = 1
    	end
    end
      if (@reservado == 1)
        @appointment.status = 1
        if (params[:appointment_date].size > 0) and (params[:start_time].size > 0) and @appointment.save
          redirect_to backoffice_path
          flash[:notice] = "Sua reserva foi solicitada a um administrador pois a sala já está reservada"
      	#redirect_to backoffice_path
      	#flash[:danger] = "Sala já reservada!"
        else
          redirect_to backoffice_path
          flash[:danger] = "Algo deu errado!"
        end
      else
        @appointment.status = 2
		    if (params[:appointment_date].size > 0) and (params[:start_time].size > 0) and @appointment.save
		      redirect_to backoffice_path
		      flash[:notice] = "Reserva realizada com sucesso!"      
		    else
		      redirect_to backoffice_path
		      flash[:danger] = "Algo deu errado!"
		    end
		      #redirect_to '/'
		  end
  end

  def show
    @room = Room.find(params[:id])
    @appointments = Appointment.where('appointment_date >= ? AND room_id = ?', Date.today.beginning_of_week, params[:id]).all
    @dates = (Date.today.beginning_of_week..Date.today.beginning_of_week+6).map{ |date| date.strftime("%a (%d/%b)") }
  end

  def edit
    @appointment = Appointment.find(params[:id])
    $status_old = @appointment.status
  end

  # Quando o status da reserva for atualizado, envia um email de notificação
  def update
    @appointment = Appointment.find(params[:id])
    if @appointment.update(appointment_params)
      redirect_to all_appointments_path
      flash.now[:notice] = "O aluguél foi editado com sucesso!"
    else
      flash.now[:danger] = "O aluguél não pôde ser editado! Tente novamente!"
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
    @appointment = Appointment.find(params[:id])
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