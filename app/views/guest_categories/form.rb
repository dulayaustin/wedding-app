# frozen_string_literal: true

class Views::GuestCategories::Form < Views::Base
  def initialize(guest_category:)
    @guest_category = guest_category
  end

  def view_template
    Form(action: form_url, method: :post, class: "space-y-4") do
      input(type: :hidden, name: "authenticity_token", value: form_authenticity_token, autocomplete: "off")
      input(type: :hidden, name: "_method", value: "patch") if @guest_category.persisted?

      FormField do
        FormFieldLabel(for: "guest_category_name") { "Name" }
        Input(
          id: "guest_category_name",
          type: :text,
          name: "guest_category[name]",
          value: @guest_category.name.to_s,
          placeholder: "Enter category name",
          required: true
        )
        FormFieldError { @guest_category.errors[:name].first } if @guest_category.errors[:name].any?
      end

      Button(type: :submit, variant: :primary, class: "w-full") { submit_label }
    end
  end

  private

  def form_url     = @guest_category.persisted? ? guest_category_path(@guest_category) : guest_categories_path
  def submit_label = @guest_category.persisted? ? "Update Category" : "Add Category"
end
