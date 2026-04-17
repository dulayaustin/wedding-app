# frozen_string_literal: true

class Views::Guests::New < Views::Base
  def initialize(guest:, categories:)
    @guest = guest
    @categories = categories
  end

  def view_template
    render Views::Layouts::Sidebar::Event.new do
      div(class: "flex items-center justify-between gap-4 mb-6 ") do
        Heading(level: 1) { "Add Guest" }
      end

      render Views::Guests::Form.new(guest: @guest, categories: @categories)
    end
  end
end
