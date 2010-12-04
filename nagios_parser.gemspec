# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "nagios_parser/version"

Gem::Specification.new do |s|
  s.name        = "nagios_parser"
  s.version     = NagiosParser::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Bernd Ahlers"]
  s.email       = ["bernd@tuneafish.de"]
  s.homepage    = "http://rubygems.org/gems/nagios_parser"
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  #s.rubyforge_project = "nagios_parser"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
end
