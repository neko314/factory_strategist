# frozen_string_literal: true

require "rspec"
require "factory_bot"
module FactoryStrategist
  # Settings to see which method is best
  module Configure
    RSpec.configure do |config|
      config.around(:example) do |ex|
        ex.run
        return if ex.exception # when spec fails with create, no-op

        alias_create_to(:build)
        alias_create_to(:build_stubbed)
        ex.run
        case ex.exception
        when nil
          ex.run
          case ex.exception
          when nil
            p "#{ex.location} create can be replaced to build"
          else
            p "#{ex.location} create can be replaced to build_stubbed"
          end
        else
          ex.run
          case ex.exception
          when nil
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
