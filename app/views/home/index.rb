# frozen_string_literal: true

class Views::Home::Index < Views::Base
  def view_template
    div(class: "min-h-screen bg-background flex flex-col items-center justify-center p-8") do
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
