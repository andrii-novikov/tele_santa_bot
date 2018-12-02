class Nickname < ApplicationRecord
  belongs_to :user, optional: true

  scope :free, -> { where(user_id: nil) }

  def to_s
    text
  end
end
