# frozen_string_literal: true

class Views::Home::Index < Views::Base
  def initialize(account:)
    @account = account
  end

  def view_template
    render Views::Layouts::Sidebar::Account.new do
      Heading(level: 1, class: "mb-1") { "Welcome, #{current_user&.first_name}!" }
      Text(class: "text-muted-foreground mb-6") { current_account&.name || "Select an account to get started." }
      Separator(class: "mb-6")

      if current_account
        div(class: "space-y-4") do
          Heading(level: 2) { "Quick Actions" }
          div(class: "flex gap-3") do
            Link(href: events_path, variant: :outline) { "View Events" }
            Link(href: new_account_path, variant: :outline) { "New Account" }
          end
        end
      else
        div(class: "space-y-4") do
          Text { "You don't have any accounts yet." }
          Link(href: new_account_path, variant: :primary) { "Create your first account" }
        end
      end
    end
  end
end
