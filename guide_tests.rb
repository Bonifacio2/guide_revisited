require 'test/unit'

require_relative 'guide'

class SentenceTest < Test::Unit::TestCase

  def test_is_statement
    sentence = Sentence.new('value is X')
    assert_equal(sentence.is_statement?, true)
  end
end
