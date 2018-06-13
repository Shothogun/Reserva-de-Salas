class Room < ApplicationRecord
	validates :name, presence: true, length: {minimum: 3, maximum: 25}
	validates :location, presence: true, length: {minimum: 3, maximum: 25}
end
