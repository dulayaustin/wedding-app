class GuestsController < ApplicationController
  def index
    @guests = Guest.all
  end

  def new
    @guest = Guest.new
  end

  def create
    @guest = Guest.new(guest_params)
    if @guest.save
      redirect_to guests_path
    end
  end

  private

  def guest_params
    params.require(:guest).permit(:first_name, :last_name)
  end
end
