# frozen_string_literal: true

class Views::Accounts::New < Views::Base
  def initialize(account:)
    @account = account
  end

  def view_template
    render Views::Layouts::Sidebar::Account.new do
      div(class: "flex items-center justify-between gap-4 mb-6") do
        Heading(level: 1) { "New Account" }
      end

      Form(action: accounts_path, method: :post, class: "space-y-4") do
        input(type: :hidden, name: "authenticity_token", value: form_authenticity_token, autocomplete: "off")

        FormField do
          FormFieldLabel(for: "account_name") { "Name" }
          Input(
            id: "account_name",
            type: :text,
            name: "account[name]",
            value: @account.name.to_s,
            placeholder: "Enter account name",
            required: true
          )
          if @account.errors[:name].any?
            FormFieldError { @account.errors[:name].first }
          end
        end

        Button(type: :submit, variant: :primary, class: "w-full") { "Create Account" }
      end
    end
  end
end
