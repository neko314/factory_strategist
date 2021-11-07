# frozen_string_literal: true

require_relative "../../lib/factory_strategist/proc_parser"

RSpec.describe ProcParser do
  using described_class

  describe "#body" do
    proc = proc { |x| x + 1 }

    it "returns codes of procedure as string" do
      expect(proc.body).to eq " |x| x + 1 "
    end
  end
end
