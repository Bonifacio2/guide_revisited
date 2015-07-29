class Sentence

  def initialize(body)
    @body = body
  end

  def is_statement?
    match_data = /^[\w]+ is [IVXLCMD]$/.match(@body)

    if match_data.nil?
      return false
    else
      return true
    end
  end
end
