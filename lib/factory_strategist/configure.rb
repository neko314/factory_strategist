# frozen_string_literal: true

require "rspec"
require "factory_bot"
require_relative "./ext/rspec/core/example/procsy"

using Ext::RSpec::Core::Example::Procsy

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

  return example.put_best_strategy(:build) if run_successfully_with?("build", example)

  example.put_best_strategy(:build_stubbed) if run_successfully_with?("build_stubbed", example)
end

def run_successfully?(example)
  example.call
  true
rescue StandardError
  false
end

def run_successfully_with?(method_name, example)
  ex = example.replaced_from_create_to(method_name)
  run_successfully?(ex)
end
