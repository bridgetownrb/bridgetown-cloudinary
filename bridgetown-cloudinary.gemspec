# frozen_string_literal: true

require_relative "lib/bridgetown-cloudinary/version"

Gem::Specification.new do |spec|
  spec.name          = "bridgetown-cloudinary"
  spec.version       = Bridgetown::Cloudinary::VERSION
  spec.author        = "Bridgetown Team"
  spec.email         = "maintainers@bridgetownrb.com"
  spec.summary       = "Embed or access images with transformations using Cloudinary"
  spec.homepage      = "https://github.com/bridgetownrb/bridgetown-cloudinary"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r!^(test|script|spec|features|frontend)/!) }
  spec.test_files    = spec.files.grep(%r!^spec/!)
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.5.0"

  spec.add_dependency "bridgetown", ">= 0.14", "< 2.0"
  spec.add_dependency "cloudinary", ">= 0.13"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "nokogiri", "~> 1.6"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop-bridgetown", "~> 0.2"
end
