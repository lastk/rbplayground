class AuthenticationPolicy
  def initialize(user_repository)
    @user_repository = user_repository
  end

  def user_with_token(email, token)
    user = @user_repository.retrieve_by_email(email)

    return if user.nil?
    return user if valid_user_for_token(user, token)
  end

  private

  def valid_user_for_token(user, token)
    user.token == token && user.token_expiration >= DateTime.now
  end

end
