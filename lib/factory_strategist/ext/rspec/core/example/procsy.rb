# frozen_string_literal: true

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
            def put_best_strategy_at(method)
              p "#{location} create can be replaced to #{method}"
            end
          end
        end
      end
    end
  end
end
