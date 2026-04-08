require 'rails_helper'

RSpec.describe AccountUser, type: :model do
  describe 'associations' do
    it { should belong_to(:account) }
    it { should belong_to(:user) }
  end

  describe 'enums' do
    it { should define_enum_for(:role).with_values(coordinator: 0, bride: 1, groom: 2) }
  end
end
