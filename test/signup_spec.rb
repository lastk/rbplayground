require 'minitest/autorun'
require 'pry'

class User
  attr_reader :name, :email, :token, :token_expiration

  def initialize(name, email, token, token_expiration)
    @name = name
    @email = email
    @token = token
    @token_expiration = token_expiration
  end
end

class Token
  attr_reader :value, :valid_until

  def initialize(value, valid_until)
    @value = value
    @valid_until = valid_until
  end
end

class TokenMachine
  require 'date'
  def new_token(valid_until=DateTime.now+1)
  end
end

class FakeTokenMachine < TokenMachine
  EXPIRATION_DATE = DateTime.new(2020,01,01)
  def new_token(valid_until=EXPIRATION_DATE)
    Token.new('ABCDEF', valid_until)
  end
end

class UserRepository
  def add
  end

  def retrieve_by_email
  end

  def retrieve_by_token
  end
end

class UserFakeRepository < UserRepository

  def initialize
    @users = {}
  end

  def add(user)
    @users[user.email] = user
  end

  def retrieve_by_email(email)
    @users[email]
  end
end


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


describe SignupUser do
  describe 'when a user is signing up' do
    it 'sould persist a user' do
      fake_repository = UserFakeRepository.new
      fake_token_machine = FakeTokenMachine.new
      signup = SignupUser.new(fake_repository, fake_token_machine)
      signup.call(name: 'rafael', email: 'rafael@booking.classes')

      persisted_user = fake_repository.retrieve_by_email('rafael@booking.classes')

      assert persisted_user, 'Couldnt retrieve the user'
      persisted_user.email.must_equal 'rafael@booking.classes'
    end

    it 'should persist user with a token and a token_expiration' do
      fake_repository = UserFakeRepository.new
      fake_token_machine = FakeTokenMachine.new

      signup = SignupUser.new(fake_repository, fake_token_machine)
      signup.call(name: 'rafael', email: 'rafael@booking.classes')

      persisted_user = fake_repository.retrieve_by_email('rafael@booking.classes')

      assert persisted_user.token, 'User doesnt have a token ;( '
      persisted_user.token.must_equal 'ABCDEF'
      persisted_user.token_expiration.must_equal  FakeTokenMachine::EXPIRATION_DATE
    end
  end
end
