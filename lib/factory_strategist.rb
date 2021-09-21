# frozen_string_literal: true

require_relative "factory_strategist/version"
require "rspec"
require "factory_bot"

# Settings to see which method is best
module FactoryStrategist
  RSpec.configure do |config|
    config.before(:suite) do |_ex|
      FactoryBot::Syntax::Methods.alias_method :create, :build_stubbed
    end

    config.after(:example) do |ex|
      case ex.exception
      when RSpec::Expectations::ExpectationNotMetError
        # no-op
      when nil
        p "#{ex.location} create can be replaced to build_stubbed"
      end
    end
  end
end
