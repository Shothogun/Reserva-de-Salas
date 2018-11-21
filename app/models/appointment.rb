class Appointment < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_many :appointbacks
  validates_presence_of :start_time
  validates_presence_of :appointment_date

end
