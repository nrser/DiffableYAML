Gem::Specification.new do |s|
  s.name        = 'diffable_yaml'
  s.version     = '0.0.1'
  s.date        = '2015-02-26'
  s.summary     = "dump YAML in Ruby with hash keys ordered to make text diffs easier"
  s.description = <<-EOS
this is a little chunck of code i use to dump Ruby objects to YAML with Hash
keys in a some-what consistent order.

i do this because i often find myself using YAML files as data storage and 
this makes it a lot easier to compare versions with text-based diff tools.

this lib is horribly alpha and has no tests what-so-ever. i'm sure it's
as full or bugs and bad ideas as 100 lines of code can be. i just put it
here so it's easier for me to use across projects. but you're welcome
to take it for a spin too if you really want.

this relies on Psych internals, so it has a dependency on pysch ~> 2.0.
it might work fine with other versions; that's just all i've tested it
against at the moment.
EOS
  s.authors     = ["Neil Souza"]
  s.email       = 'neil@neilsouza.com'
  s.files       = ["lib/diffable_yaml.rb"]
  s.homepage    =
    'https://github.com/nrser/DiffableYAML'
  s.license       = 'BSD'
  s.add_dependency 'psych', '~> 2.0'
end