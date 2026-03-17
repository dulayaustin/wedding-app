# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  def new
    self.resource = resource_class.new
    render Views::Users::Passwords::New.new(user: self.resource)
  end

  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    if successfully_sent?(resource)
      redirect_to new_user_session_path, notice: "Password reset instructions sent to your email."
    else
      render Views::Users::Passwords::New.new(user: self.resource), status: :unprocessable_entity
    end
  end
end
