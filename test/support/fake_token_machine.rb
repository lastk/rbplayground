class FakeTokenMachine < TokenMachine
  EXPIRATION_DATE = DateTime.new(2020,01,01)
  def new_token(valid_until=EXPIRATION_DATE)
    Token.new('ABCDEF', valid_until)
  end
end
