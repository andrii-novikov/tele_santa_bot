class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  def start!(*)
    UserRegisterService.call(from)
    respond_with :message, text: t('.hi')
  end

  def message(message)
    response = MessageService.call(message)

    respond_with :message, text: response
  end

  def i_wish!(*args)
    return wish_from_message(args) if args.present?

    save_context :wish_from_message
    respond_with :message, text: t('.wish_requested')
  end

  def my_wish!(*)
    text = current_user.wish ? t('.wish', wish: current_user.wish.text) : t('.no_wish')
    respond_with :message, text: text
  end

  def wish_from_message(*words)
    WishAcceptorService.call(current_user, words.join(' '))

    respond_with :message, text: t('.wish_accepted', wish: current_user.wish.text)
  end

  def users!(*)
    users = User.all.map(&:display_name).join("\n")
    respond_with :message, text: t('telegram_webhooks.registered_users.registered_users', users: users)
  end

  def lets_party!(*)
    service = SantaAssignService.new
    service.call.tap do |result|
      respond_with :message, text: service.errors.join("\n") unless result
    end
  end

  def gift!(*)
    text = current_user.recipient ? t('.gift', wish: current_user.recipient.wish) : t('.no_recipient')
    respond_with :message, text: text
  end

  private

  def current_user
    @current_user ||= User.find_by(telegram_id: from[:id])
  end
end