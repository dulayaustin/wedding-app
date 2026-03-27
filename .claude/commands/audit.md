Your goal is to update any vulnerable dependencies.

Do the following:

1. Run `bin/bundler-audit` to find vulnerable installed packages in this project
2. Run `bundle update <gem-name>` for each flagged gem
3. Run tests `bundle exec rspec` and verify the updates that didn't break anything