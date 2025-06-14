class ArticlesController < ApplicationController
  before_action :set_article, only: [ :show, :edit, :update, :destroy ]
  def index
    # N1問題対策であらかじめincludeしておく
    @articles = Article.includes(:user).all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_new_params)
    if @article.save
      redirect_to articles_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @article.update(article_new_params)
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def destroy
    if @article.destroy
      redirect_to articles_path
    else
      redirect_to article_path(@article)
    end
  end

private
  # 共通処理などはprivate内で定義
  def set_article
    @article = Article.find(params[:id])
  end

  def article_new_params
    params.require(:article).permit(:title, :about, :description)
  end
end
