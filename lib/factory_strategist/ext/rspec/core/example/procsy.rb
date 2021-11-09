# frozen_string_literal: true

require_relative "../../../../proc_parser"

using ProcParser

# Module to add methods to choose best one of FactoryBot build strategies
module Ext
  module RSpec
    module Core
      module Example
        # Module to extends class RSpec::Core::Example::Procsy
        module Procsy
          refine ::RSpec::Core::Example::Procsy do
            # Show message which build strategy of FactoryBot is the most suitable at example
            #
            # @param method_name [Symbol, String] build strategy name: `build` or `build_stubbed`
            # @return [String] message to show
            def put_best_strategy(method)
              p "#{location} create can be replaced to #{method}"
            end

            # Generate new proc to inspect the best strategy with method given as argument
            #
            # @param method_name  [Symbol, String] build strategy name: `build` or `build_stubbed`
            # @return [Proc] new example with replacing `FactoryBot#create` to passed method
            def replaced_from_create_to(method_name)
              block_body = metadata[:block].body
              new_body = "Proc.new{ #{block_body.gsub("create", method_name.to_s)} }"
              metadata[:block] = eval(new_body) # rubocop:disable Security/Eval
              self
            end
          end
        end
      end
    end
  end
end
