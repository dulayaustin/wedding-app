class Account < ApplicationRecord
  after_create :create_default_guest_categories

  has_many :account_users, dependent: :destroy
  has_many :users, through: :account_users
  has_many :guest_categories, dependent: :destroy
  has_many :guests, through: :guest_categories

  validates :name, presence: true

  private

  def create_default_guest_categories
    GuestCategory::DEFAULT_CATEGORIES.each do |name|
      guest_categories.find_or_create_by!(name: name)
    end
  end
end
