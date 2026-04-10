require 'rails_helper'

RSpec.describe "Users::Sessions", type: :request do
  let(:password) { "password123" }
  let(:user) { create(:user, password: password) }

  describe "POST /users/sign_in" do
    def sign_in_as(user)
      post user_session_path, params: { user: { email: user.email, password: password } }
    end

    context "with 1 account and 1 event" do
      let(:account) { create(:account) }
      let!(:event) { create(:event, account: account) }

      before { account.account_users.create!(user: user) }

      it "sessions the account and event" do
        sign_in_as(user)
        follow_redirect!
        expect(request.session[:account_id]).to eq(account.id)
        expect(request.session[:event_id]).to eq(event.id)
      end

      it "redirects to the event page" do
        sign_in_as(user)
        expect(response).to redirect_to(event_path(event))
      end
    end

    context "with 1 account and multiple events" do
      let(:account) { create(:account) }
      let!(:events) { create_list(:event, 2, account: account) }

      before { account.account_users.create!(user: user) }

      it "sessions the account" do
        sign_in_as(user)
        follow_redirect!
        expect(request.session[:account_id]).to eq(account.id)
      end

      it "redirects to the events index" do
        sign_in_as(user)
        expect(response).to redirect_to(events_path)
      end
    end

    context "with multiple accounts" do
      before do
        2.times { create(:account).tap { |a| a.account_users.create!(user: user) } }
      end

      it "redirects to accounts index" do
        sign_in_as(user)
        expect(response).to redirect_to(accounts_path)
      end
    end

    context "with no accounts" do
      it "redirects to accounts index" do
        sign_in_as(user)
        expect(response).to redirect_to(accounts_path)
      end
    end
  end
end
