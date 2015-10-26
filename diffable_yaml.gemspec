# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'diffable_yaml/version'

Gem::Specification.new do |spec|
  spec.name        = 'diffable_yaml'
  spec.version     = DiffableYAML::VERSION
  spec.authors     = ["nrser"]
  spec.email       = 'neil@ztkae.com'
  spec.summary     = "dump YAML in Ruby with hash keys ordered to make text diffs easier"
  spec.description = <<-EOS
this is a little chunck of code i use to dump Ruby objects to YAML with Hash
keys in a some-what consistent order.

i do this because i often find myself using YAML files as data storage and 
this makes it a lot easier to compare versions with text-based diff toolspec.

this lib is horribly alpha and has no tests what-so-ever. i'm sure it's
as full or bugs and bad ideas as 100 lines of code can be. i just put it
here so it's easier for me to use across projectspec. but you're welcome
to take it for a spin too if you really want.

this relies on Psych internals, so it has a dependency on pysch ~> 2.0.
it might work fine with other versions; that's just all i've tested it
against at the moment.
EOS
  spec.homepage      = 'https://github.com/nrser/DiffableYAML'
  spec.license       = 'BSD'
  
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  spec.add_dependency 'psych', '~> 2.0'
end
