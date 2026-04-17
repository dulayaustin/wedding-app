# frozen_string_literal: true

class Views::GuestCategories::Edit < Views::Base
  def initialize(guest_category:)
    @guest_category = guest_category
  end

  def view_template
    render Views::Layouts::Sidebar::Event.new do
      div(class: "flex items-center justify-between gap-4 mb-6 ") do
        Heading(level: 1) { "Edit Category" }
      end

      render Views::GuestCategories::Form.new(guest_category: @guest_category)
    end
  end
end
