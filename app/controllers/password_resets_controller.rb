#Classe de gerenciamento de recadastramento de senha de usuários
class PasswordResetsController < ApplicationController
  before_action :get_user,         only: [:edit, :update]
  before_action :valid_user,       only: [:edit, :update]
 
  def new
  end

  # Envia email, ou não, para recadastramento de senha
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    check_user
  end

  def edit
  end

  # Valida senha e confirmação de senha inseridas pelo usuário
  def update
    if password_empty
      blank_password                  
    elsif @user.update_attributes(user_params)
      success_password          
    else
      invalid_password
    end    
  end

  private
    def password_empty
      params[:user][:password].empty?
    end

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    # Retorna usuário
    def get_user
      @user = User.find_by(email: params[:email])
    end

    # Confirma um usuário válido
    def valid_user
       unless (@user)
        redirect_to root_url
      end
    end

    def send_email
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email enviado com instruções para troca de senha."
      redirect_to user_session_url
    end

    # Checa usuário e envia email, ou não
    def check_user
      if @user
        send_email
      else
        flash.now[:danger] = "Email não encontrado."
        render 'new'
      end
    end

    # Tratamento para senha em branco
    def blank_password
      @user.errors.add(:password, "Insira uma senha.")
      flash[:info] = "Insira uma senha."
      render 'edit'
    end

    # Tratamento para senha correta
    def success_password
      flash[:success] = "Senha alterada com sucesso."
      redirect_to user_session_url
    end
    
    # Tratamento para senha inválida
    def invalid_password
      flash[:info] = "Senha e/ou confirmação de senha incorretas. Senha precisa ter 6 caracteres."
      render 'edit'                                     
    end
end
