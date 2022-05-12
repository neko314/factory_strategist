# frozen_string_literal: true

require_relative "lib/factory_strategist/version"

Gem::Specification.new do |spec|
  spec.name          = "factory_strategist"
  spec.version       = FactoryStrategist::VERSION
  spec.authors       = ["Keiko Kaneko"]
  spec.email         = ["keiko.cda@gmail.com"]

  spec.summary       = "Checking the best factory_bot build_strategy in your test"
  spec.description   = "factory_bot supplies four build_strageries.
  factory_strategist helps you choose the best one from them."
  spec.homepage      = "https://github.com/neko314/factory_strategist"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/neko314/factory_strategist"
  spec.metadata["changelog_uri"] = "https://github.com/neko314/factory_strategist/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "factory_bot"
  spec.add_dependency "rspec"
  spec.add_development_dependency "rubocop-rake"
  spec.add_development_dependency "rubocop-rspec"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
