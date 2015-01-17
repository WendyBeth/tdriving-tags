require "test_helper"

class TaggingTest < ActiveSupport::TestCase

  def tagging
    @tagging ||= Tagging.new
  end

  def test_valid
    assert tagging.valid?
  end

end
