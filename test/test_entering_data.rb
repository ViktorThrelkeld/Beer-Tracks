require 'minitest/autorun'

class TestEnteringData < MiniTest::Unit::TestCase

  def test_something
    assert false, "Missing test implementation"
   end

  def test_valid_purchase_gets_saved
    assert false, "Missing test implementation"
  end

  def test_invalid_purchase_doesnt_get_saved
    assert false, "Missing test implementation"
  end

  def test_error_message_for_missing_tests
    assert false, "Missing test implementation"
  end

  def test_error_message_for_missing_name
    result = "./beertracks add"
    assert_equal "You must provide the name of the product you are adding", result
  end



end