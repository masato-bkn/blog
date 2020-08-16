module ArticleHelper
  def current_user_article?(id)
    return true if current_user.articles.find_by(id: id)

    false
  end
end
