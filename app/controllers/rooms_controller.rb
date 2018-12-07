#Classe de gerenciamento e controle das salas da controladora do sistema
class RoomsController < ApplicationController
	before_action :signed_in?
	before_action :is_admin?, only: [:new, :create, :destroy]
	def new
		@room = Room.new
	end

	def index
		@rooms = Room.all
	end

	def show
		@room = Room.find(params[:id])
	end

  # metodo envia todas as salas do banco de dados para a filtragem de requisição
	def filtro
		self.index
	end

	def edit
		self.show
	end

	def update
		self.show
		if @room.update(room_params)
			redirect_to @room
			flash[:notice] = "A sala foi editada com sucesso!"
		else
			flash[:danger] = "A sala não pôde ser editada! Tente novamente!"
			render 'edit'
		end
	end

	def create
		@room = Room.new(room_params)
		if @room.save
			flash[:notice] = "A sala foi criada com sucesso!"
			redirect_to backoffice_path
		else
			flash[:danger] = "A sala não pôde ser criada!"
			redirect_to backoffice_path
		end
	end

	def destroy
		self.show
		@room.destroy
		flash[:danger] = "A sala foi excluída"
		redirect_to backoffice_path
	end

	#Método de busca de salas disponíveis por dia e hora
	def search_result
		@date = params[:date_search]
		@time = params[:time_search]


		if @date.present? and @time.present?
			@search_result = Room.search_by(@date, @time)
		else
			redirect_to search_rooms_path
		end

	end

	private

	def signed_in?
		if current_user
			true
		else
			flash[:danger] = "Você não pode acessar essa página"
			return redirect_to '/'
		end
  	end

	def is_admin?
		if current_user.is_admin
			true
		else
			flash[:danger] = "Você não pode acessar essa página"
			return redirect_to '/'
		end
	end

	def room_params
		params.require(:room).permit(:name, :location, :tipo_sala)
	end
end
