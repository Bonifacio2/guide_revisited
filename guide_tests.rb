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
    first_sentence = Sentence.new('chip is X')
    first_statement  = ValueStatement.new(first_sentence)

    second_sentence = Sentence.new('blah is M')
    second_statement = ValueStatement.new(second_sentence)

    assert_equal(first_statement.key, 'chip')
    assert_equal(first_statement.value, 'X')

    assert_equal(second_statement.key, 'blah')
    assert_equal(second_statement.value, 'M')

  end
end

class PriceStatementTest < Test::Unit::TestCase

  def test_creation

    conversion_table = {'hue' => 'I'}
    first_sentence = Sentence.new('hue Silver is 7 Credits')
    silver_price_statement = PriceStatement.new(first_sentence, conversion_table)

    assert_equal(silver_price_statement.metal, 'Silver')
    assert_equal(silver_price_statement.price, 7)

    second_sentence = Sentence.new('hue Gold is 155')
    gold_price_statement = PriceStatement.new(second_sentence, conversion_table)

    assert_equal(gold_price_statement.metal, 'Gold')
    assert_equal(gold_price_statement.price, 155)

  end
end

class CurrencyTest < Test::Unit::TestCase

  def test_creation
    conversion_table = {'foo' => 'X',
      'bar' => 'I'
    }

    ten = Currency.new('foo', conversion_table)
    nine = Currency.new('bar foo', conversion_table)
    eleven = Currency.new('foo bar', conversion_table)

    assert_equal(ten.value, 10)
    assert_equal(nine.value, 9)
    assert_equal(eleven.value, 11)
  end
end

class AnswerTest < Test::Unit::TestCase

  def test_answering

    conversion_table = {
      'papu' => 'I'
    }

    price_table = {
      'Iron' => 3
    }

    sentence = Sentence.new('how much is papu papu Iron ?')

    question = Question.new(sentence, conversion_table, price_table)

    assert_equal(question.answer, 6)
  end

end

class GuideTest < Test::Unit::TestCase

  def test_creation

    input = ['glob is I',
    'prok is V',
    'pish is X',
    'tegj is L',
    'glob glob Silver is 34 Credits',
    'glob prok Gold is 57800 Credits',
    'pish pish Iron is 3910 Credits',
    'how much is pish tegj glob glob ?',
    'how many Credits is glob prok Silver ?',
    'how many Credits is glob prok Gold ?',
    'how many Credits is glob prok Iron ?',
    'how much wood could a woodchuck chuck if a woodchuck could chuck wood ?']

    expected_answers = ['pish tegj glob glob is 42',
    'glob prok Silver is 68 Credits',
    'glob prok Gold is 57800 Credits',
    'glob prok Iron is 782 Credits',
    'I have no idea what you are talking about']

    guide = Guide.new(input)
    answers = guide.answers

    assert_equal(answers, expected_answers)

  end
end
























#
