module GoodHelper
  def thumb_up?(goods)
    return false unless current_user
    return true if goods.any? { |good| good.owner?(current_user.id) }

    false
  end
end
