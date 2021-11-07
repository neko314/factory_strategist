# frozen_string_literal: true

require "./lib/factory_strategist/ext/rspec/core/example/procsy"

RSpec.describe Ext::RSpec::Core::Example::Procsy do
  using described_class

  let(:example_group) do
    RSpec.describe("group description")
  end

  let(:example_instance) do
    example_group.example("example description") { "test" }
  end

  let(:example_procsy) do
    RSpec::Core::Example::Procsy.new(example_instance)
  end

  describe "#put_best_strategy_at" do
    it do
      expect do
        example_procsy.put_best_strategy_at(:build)
      end.to output(/#{example_instance.location} create can be replaced to build/).to_stdout
    end
  end
end
