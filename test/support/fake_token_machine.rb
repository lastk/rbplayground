class FakeTokenMachine < TokenMachine
  EXPIRATION_DATE = DateTime.new(2020,01,01)
  FAKE_TOKEN = 'ABCDEF'
  def new_token(valid_until=EXPIRATION_DATE)
    Token.new(FAKE_TOKEN, valid_until)
  end
end
