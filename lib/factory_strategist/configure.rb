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
        when nil # when spec passes with build
          ex.run
          case ex.exception
          when nil # when spec passes with build_stubbed
            p "#{ex.location} create can be replaced to build_stubbed"
          else # when spec fails with build_stubbed
            p "#{ex.location} create can be replaced to build"
          end
        else # when spec fails with build
          ex.run
          case ex.exception
          when nil # when spec passes with build_stubbed
            p "#{ex.location} create can be replaced to build_stubbed"
            # else
            #   # when spec fails with build_stubbed
            #   # create is the best strategy
            #   # no-op
          end
        end
      end
    end
  end
end

def alias_create_to(method)
  FactoryBot::Syntax::Methods.alias_method :create, method
end
