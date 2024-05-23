# app/models/booking.rb

class Booking < ApplicationRecord
  belongs_to :facility

  validate :booking_time_not_overlapping

  private

  def booking_time_not_overlapping
    if facility.bookings.where.not(id: id)
                         .where('(start_time < ? AND end_time > ?) OR (start_time < ? AND end_time > ?)', end_time, start_time, end_time, start_time)
                         .exists?
      errors.add(:base, 'Booking time overlaps with existing booking')
    end
  end
end
