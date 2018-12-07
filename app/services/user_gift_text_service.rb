class UserGiftTextService < BaseService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def call
    options = {
      wish: user.recipient.wish,
      recepient_nickname: user.recipient.nickname.accusative,
      your_nickname: user.nickname.accusative
    }
    I18n.t('services.user_gift_text_service.text', options)
  end
end