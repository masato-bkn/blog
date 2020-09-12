module GoodHelper
  def thumb_up?(goods)
    return false unless current_user

    goods.any? { |good| good.owner?(current_user.id) }
  end
end
