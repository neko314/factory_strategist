# frozen_string_literal: true

require "rspec"
require "factory_bot"
module FactoryStrategist
  # Settings to see which method is best
  module Configure
    RSpec.configure do |config|
      config.around(:example) do |ex|
        detect_optimal_strategy_at(ex)
      end
    end
  end
end

private

def detect_optimal_strategy_at(example)
  return unless run_successfully?(example) # when spec fails with create, no-op

  return put_best_strategy_at(example, :build_stubbed) if run_successfully_with?(:build_stubbed, example)

  put_best_strategy_at(example, :build) if run_successfully_with?(:build, example)
end

def run_successfully?(example)
  example.run
  !example.exception
end

def put_best_strategy_at(example, method)
  p "#{example.location} create can be replaced to #{method}"
end

def run_successfully_with?(method, example)
  FactoryBot::Syntax::Methods.alias_method :create, method
  run_successfully?(example)
end
