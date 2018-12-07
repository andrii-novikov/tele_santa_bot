class User < ApplicationRecord
  belongs_to :santa, class_name: User.name, optional: true

  has_one :recipient, class_name: User.name, foreign_key: :santa_id, dependent: :nullify
  has_one :wish, dependent: :destroy
  has_one :nickname, dependent: :nullify

  scope :with_wish, -> { joins(:wish) }
  scope :without_santa, -> { where(santa_id: nil) }
  scope :random_order, -> { order('RANDOM()') }

  validates :telegram_id, uniqueness: true, presence: true
  validates :santa_id, uniqueness: true, allow_nil: true

  def send_message(text, **options)
    Telegram.bot.send_message(options.merge(chat_id: telegram_id, text: text))
  end

  def display_name
    "".tap do |result|
      result << "#{first_name} "  if first_name
      result << "#{last_name}"    if last_name
      result << "(#{username}) "  if username
      result << (wish ? '- подарок попросил' : '- подарка нет')
    end
  end
end
