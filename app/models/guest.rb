# == Schema Information
#
# Table name: guests
#
#  id                :bigint           not null, primary key
#  event_id           :bigint           not null
#  guest_category_id  :bigint
#  first_name         :string           not null
#  last_name          :string           not null
#  age_group          :integer
#  guest_of           :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_guests_on_event_id           (event_id)
#  index_guests_on_guest_category_id  (guest_category_id)
#
# Foreign Keys
#
#  event_id  (event_id => events.id)
#
class Guest < ApplicationRecord
  belongs_to :event
  belongs_to :guest_category, optional: true

  enum :age_group, { adult: 0, child: 1 }, prefix: true
  enum :guest_of, { bride: 0, groom: 1, both: 2 }, prefix: true

  validates :first_name, presence: true
  validates :last_name, presence: true
end
