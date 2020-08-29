module GoodHelper
  def thumb_up?(objects)
    return false unless current_user
    return true if objects.any? { |object| object.owner?(current_user.id) }

    false
  end
end
