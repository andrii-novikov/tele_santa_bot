class SantaAssignService < BaseService
  MIN_USERS = 2
  attr_reader :users, :last_index, :errors

  def initialize
    @users = User.with_wish.without_santa
    @last_index = users.count - 1
    @errors = []
  end

  def call
    return false unless valid?

    assign_santas
    notify_users

    true
  end

  private

  def valid?
    errors << I18n.t('services.santa_assign_service.not_enough_users') if users.count < MIN_USERS

    errors.blank?
  end

  def assign_santas
    users.each_with_index do |user, index|
      santa_index = last_index == index ? 0 : index.next
      user.update(santa: users[santa_index])
    end
  end

  def notify_users
    users.each do |user|
      nick = Petrovich(firstname: user.recipient.nickname.text).to(:genitive)
      your_nickname = Petrovich(firstname: user.nickname.text).to(:genitive)
      text = I18n.t('services.santa_assign_service.notification', wish: user.recipient.wish, nickname: nick, your_nickname: your_nickname)
      user.send_message(text)
    end
  end
end