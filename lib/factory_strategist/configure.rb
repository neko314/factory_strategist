# frozen_string_literal: true

require "rspec"
require "factory_bot"
require_relative "./proc_parser"

using ProcParser
module FactoryStrategist
  # Settings to see which method is best
  module Configure
    RSpec.configure do |config|
      config.around(:example) do |ex|
        block_body = ex.example.metadata[:block].body
        detect_optimal_strategy_at(ex)
        run_successfully_with?("build_stubbed", block_body)
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
  example.call
  true
rescue StandardError
  false
end

def put_best_strategy_at(example, method)
  p "#{example.location} create can be replaced to #{method}"
end

def run_successfully_with?(method_name, block_body)
  new_body = "Proc.new{ #{block_body.gsub("create", "#{method_name}")} }"
  example = eval(new_body)
  run_successfully?(example)
end
end
