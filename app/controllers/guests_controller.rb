class GuestsController < ApplicationController
  def index
    render Views::Guests::Index.new(guests: Guest.all)
  end

  def new
    render Views::Guests::New.new(guest: Guest.new)
  end

  def create
    guest = Guest.new(guest_params)
    if guest.save
      redirect_to guests_path
    else
      render Views::Guests::New.new(guest: guest), status: :unprocessable_entity
    end
  end

  private

  def guest_params
    params.require(:guest).permit(:first_name, :last_name)
  end
end
