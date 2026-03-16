class GuestCategory < ApplicationRecord
  belongs_to :guest
  belongs_to :account_guest_category
end
