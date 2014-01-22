require 'minitest/autorun'

class BeerTest < Minitest::Unit::TestCase
  def database
    @database ||= SQLite3::Database.new("beertracks_test")
  end

  def teardown
    database.execute("delete from entries")
  end

  def assert_command_output expected, command
  actual = `#{command}`.strip
  assert_equal expected, actual
  end
end