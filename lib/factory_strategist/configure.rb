# frozen_string_literal: true

require "rspec"
require "factory_bot"
module FactoryStrategist
  # Settings to see which method is best
  module Configure
    RSpec.configure do |config|
      config.around(:example) do |ex|
        return unless run_successfully?(ex) # when spec fails with create, no-op

        alias_create_to(:build)
        if run_successfully?(ex)
          alias_create_to(:build_stubbed)

          if run_successfully?(ex)
            p "#{ex.location} create can be replaced to build_stubbed"
          else
            p "#{ex.location} create can be replaced to build"
          end
        else
          alias_create_to(:build_stubbed)
          if run_successfully?(ex)
            p "#{ex.location} create can be replaced to build_stubbed"
          end
        end
      end
    end
  end
end

def alias_create_to(method)
  FactoryBot::Syntax::Methods.alias_method :create, method
end

def run_successfully?(example)
  example.run
  !example.exception
end
