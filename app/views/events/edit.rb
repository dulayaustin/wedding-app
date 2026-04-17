# frozen_string_literal: true

class Views::Events::Edit < Views::Base
  def initialize(event:)
    @event = event
  end

  def view_template
    render Views::Layouts::Sidebar::Event.new do
      div(class: "flex items-center justify-between gap-4 mb-6 ") do
        Heading(level: 1) { "Edit Event" }
      end

      render Views::Events::Form.new(event: @event)
    end
  end
end
