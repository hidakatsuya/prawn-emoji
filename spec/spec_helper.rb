$:.unshift File.expand_path('../../lib', __FILE__)

require 'prawn'
require 'prawn/emoji'
require 'prawn/emojidex'

require 'minitest/autorun'
require 'rr'
require 'pdf/inspector'
