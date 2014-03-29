# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sunspot-referencial_updaters/version'

Gem::Specification.new do |gem|
  gem.name          = "sunspot-referencial_updaters"
  gem.version       = Sunspot::ReferencialUpdaters::VERSION
  gem.authors       = ["Dan Carper"]
  gem.email         = ["dcarper@4moms.com"]
  gem.description   = %q{Facilitates DRY and semantic reindexing of related models}
  gem.summary       = %q{Boom}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(spec)/})
  gem.require_paths = ["lib"]

	gem.add_development_dependency "bundler"
	gem.add_development_dependency "rspec"
	gem.add_development_dependency "mocha"
	gem.add_development_dependency "pry"

end
