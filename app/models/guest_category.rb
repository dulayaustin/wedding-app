class GuestCategory < ApplicationRecord
  DEFAULT_CATEGORIES = [ "Family", "Friends", "Workmates" ].freeze

  belongs_to :event
  has_many :guests, dependent: :nullify

  validates :name, presence: true, uniqueness: { scope: :event_id }
end
