module AccountSessionable
  extend ActiveSupport::Concern

  def set_account_session(account)
    session[:account_id] = account.id
  end

  def clear_account_session
    session.delete(:account_id)
  end

  def current_account
    @current_account ||= Account.find_by(id: session[:account_id])
  end

  def require_account
    redirect_to accounts_path unless current_account
  end

  def set_event_session(event)
    session[:event_id] = event.id
  end

  def clear_event_session
    session.delete(:event_id)
  end

  def current_event
    @current_event ||= current_account&.events&.find_by(id: session[:event_id])
  end

  def require_event
    return if current_event
    if current_account&.events&.any?
      redirect_to events_path, alert: "Please select an event to continue."
    else
      redirect_to accounts_path, alert: "Please set up an event first."
    end
  end
end
