# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano-puma'

Gem::Specification.new do |gem|
  gem.name          = "capistrano-puma"
  gem.version       = Capistrano::Puma::VERSION
  gem.authors       = ["Johannes Opper"]
  gem.email         = ["xijo@gmx.de"]
  gem.description   = %q{Provide deployment tasks for puma}
  gem.summary       = %q{Provide deployment tasks for puma}
  gem.homepage      = "http://github.com/xijo/capistrano-puma"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'capistrano', '>= 3.0'
end
