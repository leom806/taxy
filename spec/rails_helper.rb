# typed: ignore
require "simplecov"
require "spec_helper"

SimpleCov.start do
  add_group "Models", "app/models/"
  add_group "Models", "app/controllers/"
  add_group "Background Jobs", "app/jobs/"
  add_group "Engines", "app/engines/"

  add_filter "config"
  add_filter "spec"
  add_filter "vendor"
end

ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../config/environment", __dir__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"

Dir[Rails.root.join("spec/config/**/*.rb")].each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  # config.filter_gems_from_backtrace("gem name")
end

RSpec::Expectations.configuration.on_potential_false_positives = :nothing
