require 'rails_helper'

RSpec.describe GuestCategory, type: :model do
  describe 'associations' do
    it { should belong_to(:event) }
    it { should have_many(:guests) }
  end

  describe 'validations' do
    subject { build(:guest_category) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:event_id) }
  end
end
