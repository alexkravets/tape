# coding: utf-8
$:.push File.expand_path('../lib', __FILE__)
require 'tape/version'

Gem::Specification.new do |s|
  s.name        = 'tape'
  s.version     = Tape::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Alexander Kravets']
  s.email       = 'alex@slatestudio.com'
  s.license     = 'MIT'
  s.homepage    = 'https://github.com/alexkravets/tape'
  s.summary     = 'RSS reader plugin for personal website.'
  s.description = <<-DESC
This plugin adds an RSS reader app that provides an easy way
to subscribe and manage website feeds.
  DESC

  s.rubyforge_project = 'tape'

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ['lib']

  s.add_dependency("chr",        ">= 0.4.0")
  s.add_dependency("ants",       ">= 0.2.0")
  s.add_dependency("mongosteen", ">= 0.1.8")
  s.add_dependency("nokogiri")
  s.add_dependency("feedjira")

  s.add_development_dependency "bundler", "~> 1.9"
  s.add_development_dependency "rake",    "~> 10.0"
end
