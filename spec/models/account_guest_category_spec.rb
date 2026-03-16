require 'rails_helper'

RSpec.describe AccountGuestCategory, type: :model do
  describe 'validations' do
    subject { build(:account_guest_category) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:account_id) }
  end
end
