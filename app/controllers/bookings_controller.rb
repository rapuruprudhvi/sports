class BookingsController < ApplicationController
  before_action :set_booking, only: %i[show edit update destroy]
  before_action :set_facility, only: %i[new create]

  def index
    @bookings = Booking.all
  end

  def show; end

  def new
    @booking = @facility.bookings.new
    @available_slots = available_slots(@facility)
  end

  def create
    @booking = @facility.bookings.new(booking_params)

    if @booking.save
      redirect_to facility_path(@facility), notice: 'Booking was successfully created.'
    else
      @available_slots = available_slots(@facility)
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @booking.update(booking_params)
      redirect_to booking_path(@booking), notice: 'Booking was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @booking.destroy
    redirect_to bookings_url, notice: 'Booking was successfully destroyed.'
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_facility
    @facility = Facility.find(params[:facility_id])
  end

  def booking_params
    params.require(:booking).permit(:start_time, :end_time)
  end

  def available_slots(facility)
    # Logic to calculate available slots
    # For simplicity, let's assume slots are 1-hour intervals from 8 AM to 8 PM
    all_slots = (8..20).map { |h| [h, h + 1] }
    booked_slots = facility.bookings.pluck(:start_time, :end_time).map { |s, e| [(s.hour), (e.hour)] }
    all_slots - booked_slots
  end
end
