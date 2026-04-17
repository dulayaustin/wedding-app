# frozen_string_literal: true

class Views::Guests::Form < Views::Base
  def initialize(guest:, categories:)
    @guest = guest
    @categories = categories
  end

  def view_template
    Form(action: form_url, method: :post, class: "space-y-4") do
      input(type: :hidden, name: "authenticity_token", value: form_authenticity_token, autocomplete: "off")
      input(type: :hidden, name: "_method", value: "patch") if @guest.persisted?

      div(class: "grid grid-cols-2 gap-4") do
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
      end

      div(class: "grid grid-cols-2 gap-4") do
        FormField do
          FormFieldLabel { "Age Group" }
          Select do
            SelectInput(name: "guest[age_group]", value: @guest.age_group.to_s, id: "guest_age_group")
            SelectTrigger do
              SelectValue(placeholder: "Select age group", id: "guest_age_group") { @guest.age_group&.humanize }
            end
            SelectContent(outlet_id: "guest_age_group") do
              SelectGroup do
                Guest.age_groups.each_key do |group|
                  SelectItem(value: group) { group.humanize }
                end
              end
            end
          end
          FormFieldError { @guest.errors[:age_group].first } if @guest.errors[:age_group].any?
        end

        FormField do
          FormFieldLabel { "Guest Of" }
          Select do
            SelectInput(name: "guest[guest_of]", value: @guest.guest_of.to_s, id: "guest_guest_of")
            SelectTrigger do
              SelectValue(placeholder: "Select guest of", id: "guest_guest_of") { @guest.guest_of&.humanize }
            end
            SelectContent(outlet_id: "guest_guest_of") do
              SelectGroup do
                Guest.guest_ofs.each_key do |side|
                  SelectItem(value: side) { side.humanize }
                end
              end
            end
          end
          FormFieldError { @guest.errors[:guest_of].first } if @guest.errors[:guest_of].any?
        end
      end

      FormField do
        FormFieldLabel { "Category" }
        Select do
          SelectInput(name: "guest[guest_category_id]", value: @guest.guest_category_id.to_s, id: "guest_category")
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
        FormFieldError { @guest.errors[:guest_category].first } if @guest.errors[:guest_category].any?
      end

      Button(type: :submit, variant: :primary, class: "w-full") { submit_label }
    end
  end

  private

  def form_url     = @guest.persisted? ? guest_path(@guest) : guests_path
  def submit_label = @guest.persisted? ? "Update Guest" : "Add Guest"
end
