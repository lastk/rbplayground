require_relative 'spec_helper'

describe AuthenticationPolicy do
  describe 'when a user is trying to sign in' do
    describe 'with a valid token and email' do
      it 'gives an user to authenticate' do
        u = User.new('rafael', 'rafael@raf.im', FakeTokenMachine::FAKE_TOKEN, FakeTokenMachine::EXPIRATION_DATE)
        fake_repository = UserFakeRepository.new

        fake_repository.add(u)
        auth_policy = AuthenticationPolicy.new(fake_repository)

        user = auth_policy.user_with_token('rafael@raf.im', FakeTokenMachine::FAKE_TOKEN)
        assert user, 'Couldnt find any user here'
      end
    end

    describe 'with an invalid token and email' do
      it 'cant get a user to authenticate' do
        u = User.new('rafael', 'rafael@raf.im', FakeTokenMachine::FAKE_TOKEN, FakeTokenMachine::EXPIRATION_DATE)
        fake_repository = UserFakeRepository.new

        fake_repository.add(u)
        auth_policy = AuthenticationPolicy.new(fake_repository)

        user = auth_policy.user_with_token('wrong email', FakeTokenMachine::FAKE_TOKEN)
        user.must_be_nil

        user = auth_policy.user_with_token('rafael@raf.im', 'wrong token')
        user.must_be_nil
      end
    end

    describe 'with an expired token' do
      it 'cant get a user to authenticate' do
        u = User.new('rafael', 'rafael@raf.im', FakeTokenMachine::FAKE_TOKEN, DateTime.now)
        fake_repository = UserFakeRepository.new

        fake_repository.add(u)
        auth_policy = AuthenticationPolicy.new(fake_repository)

        user = auth_policy.user_with_token('wrong email', FakeTokenMachine::FAKE_TOKEN)
        user.must_be_nil
      end
    end

  end
end
