require 'test/unit'

require_relative 'guide'

class SentenceTest < Test::Unit::TestCase

  def test_is_value_statement
    first_sentence = Sentence.new('value is X')
    second_sentence = Sentence.new('this is bullshit')

    assert_equal(first_sentence.is_value_statement?, true)
    assert_equal(second_sentence.is_value_statement?, false)
  end

  def test_is_price_statement
    first_sentence = Sentence.new('glob glob Silver is 34 Credits')
    second_sentence = Sentence.new('hguf huge Metal is 127 Nonsense')

    assert_equal(first_sentence.is_price_statement?, true)
    assert_equal(second_sentence.is_price_statement?, false)
  end

  def test_is_question
    first_sentence = Sentence.new('how much is pish tegj glob glob ?')
    second_sentence = Sentence.new('how much hue hue br ?')

    assert_equal(first_sentence.is_question?, true)
    assert_equal(second_sentence.is_question?, false)
  end
end

class ValueStatementTest < Test::Unit::TestCase

  def test_creation
    sentence = Sentence.new('chip is X')
    statement  = ValueStatement.new(sentence)

    assert_equal(statement.key, 'chip')
    assert_equal(statement.value, 'X')
  end
end
























#
