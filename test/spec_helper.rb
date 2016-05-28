require 'minitest/autorun'

Dir["./lib/*.rb"].each {|file| require file }
Dir["./test/support/*.rb"].each {|file| require file }
