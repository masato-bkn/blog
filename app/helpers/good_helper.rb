module GoodHelper
  def do_thumb_up?(goods)
    return false unless current_user
    return true if goods.filter { |n| n.user_id == current_user.id }.present?

    false
  end
end
