class Token
  attr_reader :value, :valid_until

  def initialize(value, valid_until)
    @value = value
    @valid_until = valid_until
  end
end
