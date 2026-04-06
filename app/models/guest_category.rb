# == Schema Information
#
# Table name: guest_categories
#
#  id         :bigint           not null, primary key
#  event_id   :bigint           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_guest_categories_on_event_id  (event_id)
#
# Foreign Keys
#
#  event_id  (event_id => events.id)
#
class GuestCategory < ApplicationRecord
  DEFAULT_CATEGORIES = [ "Family", "Friends", "Workmates" ].freeze

  belongs_to :event
  has_many :guests, dependent: :nullify

  validates :name, presence: true, uniqueness: { scope: :event_id }
end
