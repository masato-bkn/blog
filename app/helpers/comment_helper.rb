module CommentHelper
  def current_user_comment?(id)
    return true if current_user.comments.find_by(id: id)

    false
  end

  def fetch_current_user_comments
    current_user.comments.map(&:id)
  end
end
