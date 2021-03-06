# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'farma_keyboard_rails/version'

Gem::Specification.new do |spec|
  spec.name          = "farma_keyboard_rails"
  spec.version       = FarmaKeyboardRails::VERSION
  spec.authors       = ["Guilherme Zacalusni Marques"]
  spec.email         = ["gzmarques90@gmail.com"]

  spec.summary       = "This gem is intended to create a js keyboard to make a MathJax interface for sending answers and stuff."
  # spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/gzmarques/farma_keyboard_rails"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "mathjax-rails"
  spec.add_dependency "handlebars_assets"
  spec.add_dependency "codemirror-rails"
  spec.add_dependency "materialize-sass"
end
