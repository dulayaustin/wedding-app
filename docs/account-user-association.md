# AccountUser Many-to-Many Association + Controller Authorization

## Context

`User` and `Account` are currently unrelated models. The design requires users to be members of accounts, with controller-level authorization: non-logged-in users cannot access any accounts, and logged-in users can only see/manage their own accounts. We introduce an `AccountUser` join model following the same pattern as `GuestCategory` (guest ↔ account_guest_category), and use Devise's `authenticate_user!` for auth.

---

## Implementation Plan

### Part 1: Model & Migration

#### 1. Migration

```ruby
# db/migrate/<timestamp>_create_account_users.rb
create_table :account_users do |t|
  t.references :account, null: false, foreign_key: true
  t.references :user, null: false, foreign_key: true
  t.timestamps
end
add_index :account_users, [:account_id, :user_id], unique: true
```

#### 2. AccountUser model (new file)

```ruby
# app/models/account_user.rb
class AccountUser < ApplicationRecord
  belongs_to :account
  belongs_to :user
end
```

#### 3. Update Account model

```ruby
# app/models/account.rb
has_many :account_users, dependent: :destroy
has_many :users, through: :account_users
```

#### 4. Update User model

```ruby
# app/models/user.rb
has_many :account_users, dependent: :destroy
has_many :accounts, through: :account_users
```

---

### Part 2: Controller Authorization

#### 5. ApplicationController — global auth guard

Add Devise's `authenticate_user!` so no controller is accessible without login. Devise routes and `home#index` are already exempt by default.

```ruby
# app/controllers/application_controller.rb
before_action :authenticate_user!
```

#### 6. AccountsController — scope to current_user

**`index`** — list only the current user's accounts:
```ruby
def index
  render Views::Accounts::Index.new(accounts: current_user.accounts)
end
```

**`create`** — after saving, link the new account to the current user:
```ruby
def create
  @account = Account.new(account_params)
  if @account.save
    @account.account_users.create!(user: current_user)
    redirect_to accounts_path
  else
    render Views::Accounts::New.new(account: @account), status: :unprocessable_entity
  end
end
```

**`set_account`** — scope lookup to the current user's accounts. Raises `ActiveRecord::RecordNotFound` (→ 404) if the account doesn't belong to the user:
```ruby
def set_account
  @account = current_user.accounts.find(params[:id])
end
```

---

### Part 3: Tests

#### 7. New factory

```ruby
# spec/factories/account_users.rb
FactoryBot.define do
  factory :account_user do
    association :account
    association :user
  end
end
```

#### 8. New model spec

```ruby
# spec/models/account_user_spec.rb
RSpec.describe AccountUser, type: :model do
  describe "associations" do
    it { should belong_to(:account) }
    it { should belong_to(:user) }
  end
end
```

#### 9. Update existing specs

**`spec/models/account_spec.rb`** — add:
```ruby
it { should have_many(:account_users).dependent(:destroy) }
it { should have_many(:users).through(:account_users) }
```

**`spec/models/user_spec.rb`** — add:
```ruby
it { should have_many(:account_users).dependent(:destroy) }
it { should have_many(:accounts).through(:account_users) }
```

---

## Files Changed

| File | Change |
|------|--------|
| `app/models/account.rb` | Add `has_many :account_users` and `has_many :users, through:` |
| `app/models/user.rb` | Add `has_many :account_users` and `has_many :accounts, through:` |
| `app/controllers/application_controller.rb` | Add `before_action :authenticate_user!` |
| `app/controllers/accounts_controller.rb` | Scope `index`, `create`, and `set_account` to `current_user` |
| `spec/models/account_spec.rb` | Add association tests |
| `spec/models/user_spec.rb` | Add association tests |

## New Files

| File | Purpose |
|------|---------|
| `db/migrate/<timestamp>_create_account_users.rb` | Creates `account_users` table |
| `app/models/account_user.rb` | Join model |
| `spec/factories/account_users.rb` | Factory for tests |
| `spec/models/account_user_spec.rb` | Model spec |

---

## Verification

```bash
bin/rails db:migrate
bundle exec rspec spec/models/account_user_spec.rb
bundle exec rspec spec/models/account_spec.rb
bundle exec rspec spec/models/user_spec.rb
bundle exec rspec
```

Manual checks:
1. Visit any `/accounts` route while logged out → redirected to sign-in
2. Log in → see only accounts belonging to your user
3. Create an account → `account_users` row created linking it to you
4. Try accessing another user's account URL directly → 404
