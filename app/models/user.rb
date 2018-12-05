class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_accessor :reset_token

  has_many :appointments
  has_many :rooms, :through => :appointments
  
  validates :username, :course, :registration, :presence => true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def is_admin?
  	self.is_admin
  end

  # Define atributos para recadastramento de senha
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  self.reset_token)
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Retorna um token aleatório
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Envia email para recadastramento de senha
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Retorna true se um recadastramento de senha estiver expirado
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
end
