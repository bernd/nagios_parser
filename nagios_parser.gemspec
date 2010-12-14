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
  s.summary     = %q{parser lib for parsing Nagios status and config files}
  s.description = %q{
    The nagios_parser gem provides parsers for Nagios config
    and status files.
  }

  #s.rubyforge_project = "nagios_parser"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
  s.add_development_dependency "racc"
  s.add_development_dependency "rspec"
end
