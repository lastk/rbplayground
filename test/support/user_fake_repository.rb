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
