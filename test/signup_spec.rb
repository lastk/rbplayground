require_relative 'spec_helper'

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
