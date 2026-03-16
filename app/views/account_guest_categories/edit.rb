# frozen_string_literal: true

class Views::AccountGuestCategories::Edit < Views::Base
  def initialize(account_guest_category:)
    @account_guest_category = account_guest_category
  end

  def view_template
    div(class: "container mx-auto py-10 px-4 max-w-md") do
      div(class: "mb-6 flex items-center gap-4") do
        Link(href: account_guest_categories_path, variant: :ghost, size: :sm) { "← Back" }
        Heading(level: 1) { "Edit Category" }
      end

      form(action: account_guest_category_path(@account_guest_category), method: :post, class: "space-y-4") do
        input(type: :hidden, name: "authenticity_token", value: form_authenticity_token, autocomplete: "off")
        input(type: :hidden, name: "_method", value: "patch")

        FormField do
          FormFieldLabel(for: "account_guest_category_name") { "Name" }
          Input(
            id: "account_guest_category_name",
            type: :text,
            name: "account_guest_category[name]",
            value: @account_guest_category.name.to_s,
            placeholder: "Enter category name",
            required: true
          )
          if @account_guest_category.errors[:name].any?
            FormFieldError { @account_guest_category.errors[:name].first }
          end
        end

        Button(type: :submit, variant: :primary, class: "w-full") { "Update Category" }
      end
    end
  end
end
