class UserMailer < ApplicationMailer

  # Envia emails de recadastramento de senha
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Recuperação de senha"
  end

  # Envia notificações de status de reserva por email
  def status_notification(appointment)
    @appointment = appointment
    @user = appointment.user
    mail to: @user.email, subject: "Status da sua reserva"
  end
end
