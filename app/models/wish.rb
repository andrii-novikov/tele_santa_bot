class Wish < ApplicationRecord
  belongs_to :user

  validates :text, presence: true

  def to_s
    text
  end
end
