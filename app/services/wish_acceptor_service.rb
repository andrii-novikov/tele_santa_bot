class WishAcceptorService < BaseService
  attr_reader :user, :wish

  def initialize(user, wish)
    @user = user
    @wish = wish
  end

  def call
    user.build_wish unless user.wish
    user.wish.update(text: wish)
  end
end