require_relative 'helper'

class TestEnteringData < MiniTest::Unit::TestCase

  def test_something
    assert true
  end

  def test_something_too
    assert true
  end

  def test_error_message_for_missing_name
    command = "./beertracks add"
    expected = "You must provide the name of the product you are adding."
    assert_command_output expected, command
  end
end