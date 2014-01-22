require 'minitest/autorun'
require_relative '../lib/environment'

class BeerTest < Minitest::Unit::TestCase
  def database
    Environment.database_connection("test")
  end

  def teardown
    database.execute("delete from entries")
  end

  def assert_command_output expected, command
  actual = `#{command} --environment test`.strip
  assert_equal expected, actual
  end
end