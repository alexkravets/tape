require 'chr'
require 'ants'
require 'mongosteen'
require 'nokogiri'
require 'open-uri'
require 'feedjira'

module Tape
  class Engine < ::Rails::Engine
    require 'tape/engine'
  end
end
