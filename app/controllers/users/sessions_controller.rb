# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def new
    self.resource = resource_class.new
    render Views::Users::Sessions::New.new(user: self.resource)
  end
end
