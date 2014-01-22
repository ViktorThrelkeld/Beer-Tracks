require 'minitest/autorun'

class BeerTest < Minitest::Unit::TestCase
  def database
    @database ||= SQLite3::Database.new("db/beertracks_test.sqlite3")
  end

  def teardown
    database.execute("delete from entries")
  end

  def assert_command_output expected, command
  actual = `#{command}`.strip
  assert_equal expected, actual
  end
end