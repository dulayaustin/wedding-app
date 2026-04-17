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

      div(class: "space-y-4") do
        if @event.event_date.present?
          div do
            Text(class: "text-xs text-muted-foreground uppercase tracking-wide") { "Date" }
            Text(class: "mt-1") { @event.event_date.strftime("%B %-d, %Y") }
          end
          Separator
        end
        if @event.venue.present?
          div do
            Text(class: "text-xs text-muted-foreground uppercase tracking-wide") { "Venue" }
            Text(class: "mt-1") { @event.venue }
          end
          Separator
        end
        if @event.theme.present?
          div do
            Text(class: "text-xs text-muted-foreground uppercase tracking-wide") { "Theme" }
            Text(class: "mt-1") { @event.theme }
          end
        end
      end
    end
  end
end
