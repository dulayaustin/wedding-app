class ApplicationController < ActionController::Base
  include AccountSessionable

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  helper_method :current_account, :current_event

  def after_sign_in_path_for(resource)
    accounts = resource.accounts
    if accounts.size == 1
      account = accounts.first
      set_account_session(account)
      events = account.events
      if events.size == 1
        event_path(events.first)
      else
        events_path
      end
    else
      accounts_path
    end
  end
end
