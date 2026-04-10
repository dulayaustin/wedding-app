# frozen_string_literal: true

class Views::Home::Index < Views::Base
  def initialize(account:)
    @account = account
  end

  def view_template
    render Views::Layouts::Sidebar::Account.new do
      div(class: "flex items-center justify-center h-full text-muted-foreground") do
        p { "Welcome to Wed Club" }
      end
    end
  end
end
