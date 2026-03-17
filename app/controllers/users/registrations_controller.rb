# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def new
    self.resource = resource_class.new
    render Views::Users::Registrations::New.new(user: self.resource)
  end

  def create
    self.resource = resource_class.new(sign_up_params)
    if resource.save
      sign_up(resource_name, resource)
      redirect_to accounts_path, notice: "Account created successfully."
    else
      render Views::Users::Registrations::New.new(user: self.resource), status: :unprocessable_entity
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end
end
