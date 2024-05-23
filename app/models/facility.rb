class Facility < ApplicationRecord
    has_many :bookings, dependent: :destroy
  
    validates :name, :description, :location, :pincode, :sport, presence: true
  end
  