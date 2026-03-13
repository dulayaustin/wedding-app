# frozen_string_literal: true

class Views::Guests::New < Views::Base
  def initialize(guest:, categories:)
    @guest = guest
    @categories = categories
  end

  def view_template
    div(class: "container mx-auto py-10 px-4 max-w-md") do
      div(class: "mb-6 flex items-center gap-4") do
        Link(href: guests_path, variant: :ghost, size: :sm) { "← Back" }
        Heading(level: 1) { "Add Guest" }
      end

      Form(action: guests_path, method: :post, class: "space-y-4") do
        input(type: :hidden, name: "authenticity_token", value: form_authenticity_token, autocomplete: "off")

        FormField do
          FormFieldLabel(for: "guest_first_name") { "First Name" }
          Input(
            id: "guest_first_name",
            type: :text,
            name: "guest[first_name]",
            value: @guest.first_name.to_s,
            placeholder: "Enter first name",
            required: true
          )
          FormFieldError { @guest.errors[:first_name].first } if @guest.errors[:first_name].any?
        end

        FormField do
          FormFieldLabel(for: "guest_last_name") { "Last Name" }
          Input(
            id: "guest_last_name",
            type: :text,
            name: "guest[last_name]",
            value: @guest.last_name.to_s,
            placeholder: "Enter last name",
            required: true
          )
          FormFieldError { @guest.errors[:last_name].first } if @guest.errors[:last_name].any?
        end

        FormField do
          FormFieldLabel { "Category" }
          Select do
            SelectInput(name: "guest[guest_category_id]", value: @guest.guest_guest_category&.guest_category_id.to_s, id: "guest_category")
            SelectTrigger do
              SelectValue(placeholder: "Select a category", id: "guest_category") { @guest.guest_category&.name }
            end
            SelectContent(outlet_id: "guest_category") do
              SelectGroup do
                @categories.each do |category|
                  SelectItem(value: category.id.to_s) { category.name }
                end
              end
            end
          end
        end

        Button(type: :submit, variant: :primary, class: "w-full") { "Add Guest" }
      end
    end
  end
end
