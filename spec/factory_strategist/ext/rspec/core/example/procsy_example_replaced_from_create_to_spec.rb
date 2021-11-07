# frozen_string_literal: true

require "./lib/factory_strategist/ext/rspec/core/example/procsy"
require_relative "../../../../../../lib/factory_strategist/proc_parser"

RSpec.describe Ext::RSpec::Core::Example::Procsy do
  using described_class
  using ProcParser

  let(:example_group) do
    RSpec.describe("group description")
  end

  let(:example_instance) do
    example_group.example("example description") { p "create" }
  end

  let(:example_procsy) do
    RSpec::Core::Example::Procsy.new(example_instance)
  end

  describe "#example_replaced_from_create_to" do
    it "replaces from `create` to passed method in matadata[:block]" do
      new_example = example_procsy.example_replaced_from_create_to(:build)
      expect { new_example.metadata[:block].call }.to output(/build/).to_stdout
    end
  end
end
