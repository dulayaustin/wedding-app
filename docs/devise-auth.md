# Devise Registration & Login

## Context

The app has Devise installed on the `User` model (`database_authenticatable, registerable, recoverable, rememberable, validatable`) with `first_name` and `last_name` custom fields. `devise_for :users` is already in routes. The view layer is **Phlex** (Ruby classes, not ERB), so Devise's default ERB views cannot be used — custom controllers that render Phlex view classes are needed.

---

## Files to Create

### 1. `config/routes.rb` — Wire custom controllers

Add `controllers:` option to `devise_for`:

```ruby
devise_for :users, controllers: {
  sessions: "users/sessions",
  registrations: "users/registrations",
  passwords: "users/passwords"
}
```

### 2. `app/controllers/users/sessions_controller.rb`

```ruby
class Users::SessionsController < Devise::SessionsController
  def new
    self.resource = resource_class.new
    render Views::Users::Sessions::New.new(user: self.resource)
  end
end
```

Devise handles `create`/`destroy` automatically. `after_sign_in_path_for` is defined in `ApplicationController`.

### 3. `app/controllers/users/registrations_controller.rb`

```ruby
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def new
    self.resource = resource_class.new
    render Views::Users::Registrations::New.new(user: self.resource)
  end

  def create
    self.resource = resource_class.new(sign_up_params)
    if resource.save
      sign_up(resource_name, resource)
      redirect_to accounts_path, notice: "Account created successfully."
    else
      render Views::Users::Registrations::New.new(user: self.resource), status: :unprocessable_entity
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end
end
```

### 4. `app/controllers/users/passwords_controller.rb`

```ruby
class Users::PasswordsController < Devise::PasswordsController
  def new
    self.resource = resource_class.new
    render Views::Users::Passwords::New.new(user: self.resource)
  end

  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    if successfully_sent?(resource)
      redirect_to new_user_session_path, notice: "Password reset instructions sent to your email."
    else
      render Views::Users::Passwords::New.new(user: self.resource), status: :unprocessable_entity
    end
  end
end
```

### 5. `app/views/users/sessions/new.rb`

Sign-in form with: email, password, remember_me checkbox.
Links to sign-up and forgot-password pages.
Form action: `user_session_path` (POST).

### 6. `app/views/users/registrations/new.rb`

Sign-up form with: first_name, last_name, email, password, password_confirmation.
Link to sign-in page.
Form action: `user_registration_path` (POST).

### 7. `app/views/users/passwords/new.rb`

Forgot-password form with: email field.
Link back to sign-in.
Form action: `user_password_path` (POST).

All views follow the existing Phlex pattern:

```ruby
class Views::Users::Sessions::New < Views::Base
  def initialize(user:)
    @user = user
  end

  def view_template
    div(class: "container mx-auto py-10 px-4 max-w-md") do
      div(class: "mb-6 flex items-center gap-4") do
        Link(href: root_path, variant: :ghost, size: :sm) { "← Back" }
        Heading(level: 1) { "Sign In" }
      end

      Form(action: user_session_path, method: :post, class: "space-y-4") do
        input(type: :hidden, name: "authenticity_token", value: form_authenticity_token, autocomplete: "off")

        FormField do
          FormFieldLabel(for: "user_email") { "Email" }
          Input(id: "user_email", type: :email, name: "user[email]", value: @user.email.to_s, required: true)
          FormFieldError { @user.errors[:email].first } if @user.errors[:email].any?
        end

        Button(type: :submit, variant: :primary, class: "w-full") { "Sign In" }
      end
    end
  end
end
```

---

## Files to Modify

### 8. `app/controllers/application_controller.rb`

Add `after_sign_in_path_for` to redirect to accounts after login/registration:

```ruby
def after_sign_in_path_for(_resource)
  accounts_path
end
```

### 9. `app/views/layouts/application.html.erb`

Add flash messages before `<main>` using the RubyUI `Alert` component via `render`:

```erb
<body>
  <% if notice.present? %>
    <div class="container mx-auto px-4 pt-4">
      <%= render RubyUI::Alert.new(variant: :success) do %>
        <%= render RubyUI::AlertDescription.new do %>
          <%= notice %>
        <% end %>
      <% end %>
    </div>
  <% end %>
  <% if alert.present? %>
    <div class="container mx-auto px-4 pt-4">
      <%= render RubyUI::Alert.new(variant: :destructive) do %>
        <%= render RubyUI::AlertDescription.new do %>
          <%= alert %>
        <% end %>
      <% end %>
    </div>
  <% end %>
  <main class="container mx-auto py-8 px-4 sm:px-6 lg:px-8 flex flex-col">
    <%= yield %>
  </main>
</body>
```

### 10. `app/views/home/index.rb`

Update the nav `div(class: "flex items-center gap-1")` block to add `current_user` branching:

- When **not signed in**: show "Sign In" (ghost) and "Sign Up" (primary) links
- When **signed in**: keep existing account logic + add user's first name and a Sign Out form (DELETE to `destroy_user_session_path`)

---

## Verification

1. `bundle exec rspec` — run existing tests (should still pass)
2. Start server: `bin/dev`
3. Visit `/` → nav shows "Sign In" / "Sign Up" links when logged out
4. Visit `/users/sign_up` → registration form renders with all 5 fields
5. Register a new user → redirected to `/accounts`
6. Visit `/users/sign_in` → login form renders
7. Sign in → redirected to `/accounts`
8. Sign out → redirected to `/`
9. Visit `/users/password/new` → forgot password form renders
10. Submit invalid email → form re-renders with error
