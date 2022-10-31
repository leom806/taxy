# typed: strict
require "database_cleaner/active_record"

DatabaseCleaner.strategy = :truncation

ENV["RAILS_ENV"] = "test"
$LOAD_PATH.concat(Dir["#{File.expand_path("../app", __dir__)}/*"])

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.disable_monkey_patching!

  config.order = :random
  Kernel.srand config.seed

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end
end
