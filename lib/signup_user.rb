class SignupUser
  def initialize(repository, token_machine)
    @repository = repository
    @token_machine = token_machine
  end

  def call(params)
    user = User.new(params[:name], params[:email], token.value, token.valid_until)
    @repository.add(user)
  end

  private

  def token
    @token_machine.new_token
  end
end
