# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "tw-animate-css", to: "https://cdn.jsdelivr.net/npm/tw-animate-css/dist/tw-animate.css"
pin_all_from "app/javascript/controllers", under: "controllers"
