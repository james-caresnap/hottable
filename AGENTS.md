# Repository Guidelines

## Project Structure & Module Organization
HotTable is a Rails 7 + Hotwire app. Most application code lives under `app/`: controllers orchestrate queries and models wrap PostgreSQL data. Phlex components reside in `app/components`; add reusable table widgets here instead of ERB partials. Stimulus logic sits in `app/javascript/controllers` with files named `*_controller.js`, while Tailwind entrypoints are under `app/assets/stylesheets`. Put domain-specific service objects into `lib/`, and keep database migrations and seeds in `db/migrate` and `db/seeds.rb`. Static assets belong in `public/`, with optional UI captures in `screenshots/`.

## Build, Test, and Development Commands
Run `bin/setup` once per machine to install gems, Node modules, and prepare the database. During day-to-day development, `bin/dev` boots the Rails server plus the asset watchers defined in `Procfile.dev`. Use `bin/rails db:prepare` after pulling new migrations, and `yarn build` / `yarn build:css` when you need production-ready bundles.

## Coding Style & Naming Conventions
Follow standard Ruby 3.4 conventions: two-space indentation, snake_case methods, and singular model names. Phlex components inherit from the shared base component and should expose expressive method names instead of inline HTML. Stimulus controllers export classes whose identifiers mirror the filename (`records_table_controller`). Tailwind utility classes handle most styling; avoid ad-hoc CSS outside `application.tailwind.css`.

## Testing Guidelines
The project currently lacks automated tests—new features must include Minitest coverage under `test/` (e.g., `test/models`, `test/system`). Name files `*_test.rb` and favor meaningful fixture data or factories. Run `RAILS_ENV=test bin/rails db:prepare` when schema changes occur, then execute `bin/rails test` or `bin/rails test:system` before opening a PR. For complex table interactions, add brief manual verification notes or GIFs.

## Commit & Pull Request Guidelines
Commits in this repo use short, imperative summaries (`Upgrade to phlex-rails`, `update dependencies`). Keep related changes in a single commit and describe motivation plus notable implementation details in the body when needed. Pull requests should link to an issue, show UI screenshots stored in `screenshots/`, and list the test commands you ran. Flag breaking migrations or data scripts in the PR description so deployers can plan the rollout.

## Security & Configuration Tips
Rails credentials and environment variables belong in `config/credentials.yml.enc` or the hosting platform; never commit `.env` files or API keys. The app depends on PostgreSQL and Redis, so document required service versions in PRs. When adjusting Hotwire or Stimulus behavior, confirm Turbo Streams still authorize correctly and avoid leaking sensitive fields in broadcast payloads.
