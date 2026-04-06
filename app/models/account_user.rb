# == Schema Information
#
# Table name: account_users
#
#  id         :bigint           not null, primary key
#  account_id :bigint           not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_account_users_on_account_id                      (account_id)
#  index_account_users_on_account_id_and_user_id          (account_id,user_id) UNIQUE
#  index_account_users_on_user_id                         (user_id)
#
# Foreign Keys
#
#  account_id  (account_id => accounts.id)
#  user_id     (user_id => users.id)
#
class AccountUser < ApplicationRecord
  belongs_to :account
  belongs_to :user
end
