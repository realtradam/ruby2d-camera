# frozen_string_literal: true

require_relative "lib/ruby2d/camera/version"

Gem::Specification.new do |spec|
  spec.name          = "ruby2d-camera"
  spec.version       = Ruby2d::Camera::VERSION
  spec.authors       = ["Tradam"]
  spec.email         = ["ruby2d-camera@tradam.dev"]

  spec.summary       = "A library for camera movement in the Ruby2D gem"
  #spec.description   = "TODO: Write a longer description or delete this line."
  spec.homepage      = "https://github.com/realtradam/ruby2d-camera"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to 'https://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/realtradam/ruby2d-camera"
  #spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features|assets|example)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "ruby2d", "~> 0.10"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
