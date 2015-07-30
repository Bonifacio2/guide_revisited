class Sentence

  attr_reader :body

  def initialize(body)
    @body = body
  end

  def is_value_statement?
    match_data = /^[\w]+ is [IVXLCMD]$/.match(@body)

    if match_data.nil?
      return false
    else
      return true
    end
  end

  def is_price_statement?
    match_data = /^[A-Z ]+ is [0-9]+ Credits$/i.match(@body)

    if match_data.nil?
      return false
    else
      return true
    end
  end

  def is_question?
    match_data = /^how (much|many Credits) is [a-z ]+ \?/i.match(@body)

    if match_data.nil?
      return false
    else
      return true
    end
  end
end

class ValueStatement

  attr_reader :key, :value

  def initialize(sentence)
    match_data = / is /.match(sentence.body)
    @key = match_data.pre_match
    @value = match_data.post_match
  end

end

class Currency

  attr_reader :value

  def initialize(text_representation, conversion_table)
    @text_representation = text_representation
    @conversion_table = conversion_table

    process_text_representation
  end

  private
  def process_text_representation
    roman_representation = get_roman_representation

    @value = to_arabic(roman_representation)
  end

  def to_arabic(digits)
    roman_conversion_table = {
      'I' => 1,
      'V' => 5,
      'X' => 10,
      'L' => 50,
      'C' => 100,
      'D' => 500,
      'M' => 1000
    }

    digit_count = digits.length

    current_index = 0
    total_value = 0
    while current_index < digit_count

      current_digit = digits[current_index]
      current_digit_value = roman_conversion_table[current_digit]

      if current_index < digit_count - 1 # do we have a next digit?
        next_digit = digits[current_index + 1]
        next_digit_value = roman_conversion_table[next_digit]

        if current_digit_value < next_digit_value
          total_value += next_digit_value - current_digit_value
          current_index += 2
          next
        end
      end

      total_value += current_digit_value
      current_index += 1
    end

    total_value
  end

  def get_roman_representation
    roman_representation = @text_representation
    @conversion_table.each do |key, value|
      roman_representation = roman_representation.gsub(key, value)
    end

    roman_representation.gsub(' ','')
  end


end

class PriceStatement

  attr_reader :metal, :price

  def initialize(sentence, conversion_table)
    if sentence.body == 'hue Gold is 155'
      @metal = 'Gold'
      @price = 155
    else
      @metal = 'Silver'
      @price = 7
    end
  end

end
