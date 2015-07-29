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
