require 'minitest/reporters'
require 'minitest/autorun'
require 'pry'

Dir[Dir.pwd + "/lib/*.rb"].each {|file| require file }

Minitest::Reporters.use!(Minitest::Reporters::DefaultReporter.new)

class Minitest::Unit::TestCase
end
