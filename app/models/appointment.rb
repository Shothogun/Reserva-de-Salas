#Classe responsável pelo gerenciamento da model de reservas de sala
class Appointment < ApplicationRecord
  belongs_to :room
  belongs_to :user
  validates_presence_of :start_time
  validates_presence_of :appointment_date

  # Envia notificação de status por email
  def send_status_notification_email
    UserMailer.status_notification(self).deliver_now
  end
end

