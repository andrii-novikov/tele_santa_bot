class MessageService < BaseService
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def call
    return add_to_group_message if added_to_group?
    didnt_understand
  end

  private

  def didnt_understand
    I18n.t('services.message_service.didnt_understand')
  end

  def added_to_group?
    message.new_chat_members&.any? { |m| m.username == 'tele_santa_bot' }
  end

  def add_to_group_message
    I18n.t('services.message_service.added_to_group')
  end
end
