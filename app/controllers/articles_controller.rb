class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  def index
    @articles = Article.all
  end

  def new
  end

  def create
    @article = Article.new(article_new_params)
    if @article.save
      redirect_to articles_path
    else
      render :new, status: :unprocessable_entity
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
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @article
      @article.destroy
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
