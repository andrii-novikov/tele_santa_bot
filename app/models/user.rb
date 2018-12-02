class User < ApplicationRecord
  belongs_to :santa, class_name: User.name, optional: true

  has_one :recipient, class_name: User.name, foreign_key: :santa_id, dependent: :nullify
  has_one :wish, dependent: :destroy

  validates :telegram_id, uniqueness: true
end
