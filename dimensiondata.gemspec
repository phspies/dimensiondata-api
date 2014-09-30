# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "dimensiondata/version"

Gem::Specification.new do |s|
  s.name        = "dimensiondata"
  s.version     = DimensionData::VERSION
  s.authors     = ["Phillip Spies"]
  s.email       = ["fspies0@hotmail.com"]
  s.homepage    = ""
  s.summary     = %q{Dimension Data Cloud API gem}
  s.description = %q{Wapper to access Dimension Data cloud's api'}

  s.rubyforge_project = "dimensiondata"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'i18n'
  s.add_dependency 'activesupport'
  s.add_dependency 'typhoeus'
  s.add_dependency 'xml-simple'
  s.add_dependency 'hashie'
  s.add_dependency 'colorize'
end
