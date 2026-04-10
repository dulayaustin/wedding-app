# frozen_string_literal: true

class Views::Events::Index < Views::Base
  def initialize(events:)
    @events = events
  end

  def view_template
    render Views::Layouts::Sidebar::Account.new do
      div(class: "flex items-center justify-between mb-6") do
        Heading(level: 1) { "Events" }
      end

      Table do
        TableHeader do
          TableRow do
            TableHead { "Name" }
            TableHead { "Date" }
            TableHead { "Actions" }
          end
        end
        TableBody do
          if @events.any?
            @events.each do |event|
              TableRow do
                TableCell { event.title }
                TableCell { event.event_date&.strftime("%b %-d, %Y") || "—" }
                TableCell do
                  Link(href: event_path(event), variant: :outline, size: :sm) { "Select" }
                end
              end
            end
          else
            TableRow do
              TableCell(class: "text-center text-muted-foreground py-8", colspan: "3") do
                "No events yet."
              end
            end
          end
        end
      end
    end
  end
end
