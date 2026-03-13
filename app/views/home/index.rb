# frozen_string_literal: true

class Views::Home::Index < Views::Base
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
          end
        end
      end

      # Hero
      div(class: "flex-1 flex flex-col items-center justify-center p-8") do
        div(class: "text-center space-y-6 max-w-2xl") do
          Heading(level: 1) { "Welcome to Our Wedding" }
          Text(size: "lg", weight: "muted") { "We're so excited to celebrate with you!" }
          div(class: "pt-2") do
            Link(href: guests_path, variant: :primary, size: :lg) { "View Guest List" }
          end
        end
      end
    end
  end
end
