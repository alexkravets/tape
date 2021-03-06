# coding: utf-8
$:.push File.expand_path("../lib", __FILE__)
require "tape/version"

Gem::Specification.new do |s|
  s.name        = "tape-chr"
  s.version     = Tape::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Alexander Kravets"]
  s.email       = "alex@slatestudio.com"
  s.summary     = "RSS reader for Character based website"
  s.homepage    = "https://github.com/alexkravets/tape"
  s.license     = "MIT"

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency "chr", ">= 0.4.0"
  s.add_dependency "ants", ">= 0.2.0"
  s.add_dependency "mongosteen", ">= 0.1.8"
  s.add_dependency "nokogiri"
  s.add_dependency "feedjira"

  s.add_development_dependency "bundler", "~> 1.9"
  s.add_development_dependency "rake",    "~> 10.0"
end
