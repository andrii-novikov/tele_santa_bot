class UserRegisterService < BaseService
  attr_reader :from

  def initialize(from)
    @from = from
  end

  def call
    User.create(telegram_id: from.id, username: from.username, first_name: from.first_name, last_name: from.last_name, nickname: Nickname.free.sample)
  end
end
