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
      user.send_message(I18n.t('services.santa_assign_service.notification'))
      user.send_message(UserGiftTextService.call(user), parse_mode: :Markdown)
    end
  end
end