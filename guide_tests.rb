require 'test/unit'

require_relative 'guide'

class SentenceTest < Test::Unit::TestCase

  def test_is_value_statement
    first_sentence = Sentence.new('value is X')
    second_sentence = Sentence.new('this is bullshit')

    assert_equal(first_sentence.is_value_statement?, true)
    assert_equal(second_sentence.is_value_statement?, false)
  end
end
