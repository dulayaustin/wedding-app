# frozen_string_literal: true

class Views::Home::Index < Views::Base
  def initialize(account:)
    @account = account
  end

  def view_template
    div(class: "min-h-screen bg-background flex flex-col") do
      nav(class: "border-b border-border bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60") do
        div(class: "container mx-auto px-4 h-16 flex items-center justify-between") do
          # Logo
          a(href: root_path, class: "flex items-center gap-2 text-foreground no-underline") do
            div(class: "h-9 w-9 rounded-full bg-primary flex items-center justify-center text-primary-foreground font-bold text-lg") { "W" }
            span(class: "font-semibold text-base hidden sm:inline") { "Wed Club" }
          end

          # Nav links
          div(class: "flex items-center gap-1") do
            Link(href: root_path, variant: :ghost, size: :sm) { "Home" }
            Link(href: guests_path, variant: :ghost, size: :sm) { "Guests" }
            if helpers.current_user
              if helpers.current_account
                span(class: "text-sm text-muted-foreground px-2") { helpers.current_account.name }
                form(action: account_session_path, method: :post) do
                  input(type: :hidden, name: "authenticity_token", value: form_authenticity_token, autocomplete: "off")
                  input(type: :hidden, name: "_method", value: "delete")
                  Button(type: :submit, variant: :ghost, size: :sm) { "Switch Account" }
                end
              else
                Link(href: accounts_path, variant: :ghost, size: :sm) { "Select Account" }
              end
              span(class: "text-sm text-muted-foreground px-2") { helpers.current_user.first_name }
              form(action: destroy_user_session_path, method: :post) do
                input(type: :hidden, name: "authenticity_token", value: form_authenticity_token, autocomplete: "off")
                input(type: :hidden, name: "_method", value: "delete")
                Button(type: :submit, variant: :ghost, size: :sm) { "Sign Out" }
              end
            else
              Link(href: new_user_session_path, variant: :ghost, size: :sm) { "Sign In" }
              Link(href: new_user_registration_path, variant: :primary, size: :sm) { "Sign Up" }
            end
          end
        end
      end
    end
  end
end
