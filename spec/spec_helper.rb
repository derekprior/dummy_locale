$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "dummy_locale"

RSpec.configure do |config|
  config.before(:each) do
    I18n.backend = I18n::Backend::Simple.new
    I18n.load_path = []
  end

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  config.example_status_persistence_file_path = "tmp/rspec_examples.txt"
  config.order = :random
end
