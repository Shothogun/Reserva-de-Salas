#Classe de gerenciamento de recadastramento de senha de usuários
class PasswordResetsController < ApplicationController
  before_action :get_user,         only: [:edit, :update]
  before_action :valid_user,       only: [:edit, :update]
  #before_action :check_expiration, only: [:edit, :update]   

  def new
  end

  # Envia email, ou não, para recadastramento de senha
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email enviado com instruções para troca de senha."
      redirect_to user_session_url
    else
      flash.now[:danger] = "Email não encontrado."
      render 'new'
    end
  end

  def edit
  end

  # Valida senha e confirmação de senha inseridas pelo usuário
  def update
    if params[:user][:password].empty?                  
      @user.errors.add(:password, "Insira uma senha.")
      flash[:info] = "Insira uma senha."
      render 'edit'
    elsif @user.update_attributes(user_params)          
      flash[:success] = "Senha alterada com sucesso."
      redirect_to user_session_url
    else
      flash[:info] = "Senha e/ou confirmação de senha incorretas. Senha precisa ter 6 caracteres."
      render 'edit'                                     
    end
  end

  private

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

    # Checa vencimento do token de recadastramento
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "Link expirado."
        redirect_to user_session_url
      end
    end
end
