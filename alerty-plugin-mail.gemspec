# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'alerty/plugin/mail/version'

Gem::Specification.new do |spec|
  spec.name          = "alerty-plugin-mail"
  spec.version       = Alerty::Plugin::Mail::VERSION
  spec.authors       = ["Civitaspo"]
  spec.email         = ["civitaspo@gmail.com"]

  spec.summary       = %q{mail plugin for alerty}
  spec.description   = %q{mail plugin for alerty}
  spec.homepage      = "https://github.com/civitaspo/alerty-plugin-mail"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'alerty'
  spec.add_dependency 'mail'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "test-unit"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-nav"
end
