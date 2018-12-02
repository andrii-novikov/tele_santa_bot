class UserRegisterService < BaseService
  attr_reader :from

  def initialize(from)
    @from = from
  end

  def call
    User.create(telegram_id: from.id, username: from.username)
  end
end
