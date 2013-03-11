#!/usr/bin/env ruby
require 'gists/isight_capture'

isight = Gists::ISightCapture.new

puts "capturing"
isight.capture()
