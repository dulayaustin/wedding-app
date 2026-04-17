# frozen_string_literal: true

class Views::Accounts::Form < Views::Base
  def initialize(account:)
    @account = account
  end

  def view_template
    Form(action: form_url, method: :post, class: "space-y-4") do
      input(type: :hidden, name: "authenticity_token", value: form_authenticity_token, autocomplete: "off")
      input(type: :hidden, name: "_method", value: "patch") if @account.persisted?

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
        FormFieldError { @account.errors[:name].first } if @account.errors[:name].any?
      end

      Button(type: :submit, variant: :primary, class: "w-full") { submit_label }
    end
  end

  private

  def form_url     = @account.persisted? ? account_path(@account) : accounts_path
  def submit_label = @account.persisted? ? "Update Account" : "Create Account"
end
