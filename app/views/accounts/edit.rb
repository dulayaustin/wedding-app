# frozen_string_literal: true

class Views::Accounts::Edit < Views::Base
  def initialize(account:)
    @account = account
  end

  def view_template
    render Views::Layouts::Sidebar::Account.new do
      div(class: "flex items-center justify-between gap-4 mb-6") do
        Heading(level: 1) { "Edit Account" }
      end

      render Views::Accounts::Form.new(account: @account)
    end
  end
end
