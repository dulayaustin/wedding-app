class AccountGuestCategory < ApplicationRecord
  DEFAULT_CATEGORIES = [ "Family", "Friends", "Workmates" ].freeze

  belongs_to :account
  has_many :guests, dependent: :nullify

  validates :name, presence: true, uniqueness: { scope: :account_id }
end
