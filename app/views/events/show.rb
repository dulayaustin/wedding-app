# frozen_string_literal: true

class Views::Events::Show < Views::Base
  def initialize(event:)
    @event = event
  end

  def view_template
    render Views::Layouts::Sidebar::Event.new do
      div(class: "mb-6 flex items-center justify-between") do
        Heading(level: 1) { @event.title }
        Link(href: edit_event_path(@event), variant: :outline, size: :sm) { "Edit Details" }
      end

      div(class: "space-y-2") do
        if @event.event_date.present?
          p { "Date: #{@event.event_date.strftime("%B %-d, %Y")}" }
        end
        if @event.venue.present?
          p { "Venue: #{@event.venue}" }
        end
        if @event.theme.present?
          p { "Theme: #{@event.theme}" }
        end
      end
    end
  end
end
