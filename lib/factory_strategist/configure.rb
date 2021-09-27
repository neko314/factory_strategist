# frozen_string_literal: true

require "rspec"
require "factory_bot"
module FactoryStrategist
  # Settings to see which method is best
  module Configure
    RSpec.configure do |config|
      config.after(:example) do |ex|
        case ex.exception
        when nil # when spec passes with create
          FactoryBot::Syntax::Methods.alias_method :create, :build
          case ex.exception
          when nil # when spec passes with build
            FactoryBot::Syntax::Methods.alias_method :create, :build_stubbed
            case ex.exception
            when nil # when spec passes with build_stubbed
              p "#{ex.location} create can be replaced to build_stubbed"
            else # when spec fails with build_stubbed
              p "#{ex.location} create can be replaced to build"
            end
          else # when spec fails with build
            FactoryBot::Syntax::Methods.alias_method :create, :build_stubbed
            case ex.exception
            when nil # when spec passes with build_stubbed
              p "#{ex.location} create can be replaced to build_stubbed"
              # else
              #   # when spec fails with build_stubbed
              #   # create is the best strategy
              #   # no-op
            end
          end
          # else
          #   # when spec fails with create
          #   # no-op
        end
      end
    end
  end
end
