class User < ApplicationRecord
  belongs_to :santa, class_name: User.name, optional: true

  has_many :recipients, class_name: User.name, foreign_key: :santa_id
  has_many :wishes
end
