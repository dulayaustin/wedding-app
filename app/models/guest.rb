class Guest < ApplicationRecord
  belongs_to :event
  belongs_to :guest_category, optional: true

  enum :age_group, { adult: 0, child: 1 }, prefix: true
  enum :guest_of, { bride: 0, groom: 1, both: 2 }, prefix: true

  validates :first_name, presence: true
  validates :last_name, presence: true
end
