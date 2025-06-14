module ArticlesHelper
    def own_article?(article)
      current_user&.id == article.user_id
    end
end
