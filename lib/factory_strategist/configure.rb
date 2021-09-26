# frozen_string_literal: true

require "rspec"
require "factory_bot"
module FactoryStrategist
  # Settings to see which method is best
  module Configure
    RSpec.configure do |config|
      config.before(:suite) do |_ex|
        FactoryBot::Syntax::Methods.alias_method :create, :build_stubbed
      end

      config.after(:example) do |ex|
        case ex.exception
        when nil
        else
          # no-op
        end
      end
    end
  end
end
