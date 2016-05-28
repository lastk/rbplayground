class User
  attr_reader :name, :email, :token, :token_expiration

  def initialize(name, email, token, token_expiration)
    @name = name
    @email = email
    @token = token
    @token_expiration = token_expiration
  end
end
