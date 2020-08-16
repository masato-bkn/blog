module CommentHelper
  def current_user_comment?(id)
    return true if current_user.comments.find_by(id: id)

    false
  end
end
