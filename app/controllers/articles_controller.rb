class ArticlesController < ApplicationController
  before_action :require_login, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_article, only: [ :show, :edit, :update, :destroy ]
  # edit, update, destroy アクションで記事の作成者かチェック
  before_action :check_article_owner, only: [ :edit, :update, :destroy ]

  def index
    MIN_PAGE_LIMIT = 5
    @page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @articles = Article.page(@page).per(MIN_PAGE_LIMIT)
  end

  def new
    @article = Article.new
  end

  def create
    tag_name_list = params[:article][:tag_string].split(',').map(:&strip)
    # タグの取得
    tags = tag_name_list.map do |name|
      Tag.find_orcreate_by(name: name)
    end
    @article = current_user.articles.build(article_new_params.except(:tags_string))
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
      flash[:notice] = "記事の削除が成功しました。"
      redirect_to articles_path
    else
      flash[:alert] = "記事の削除が失敗しました。"
      redirect_to article_path(@article)
    end
  end

private
  # 共通処理などはprivate内で定義
  def set_article
    @article = Article.find(params[:id])

    # 記事が見つからなかった場合の例外を捕捉し、処理を終了してからリダイレクト
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "お探しの記事は見つかりませんでした。"
      redirect_to articles_path and return
  end

  def article_new_params
    params.require(:article).permit(:title, :about, :description, :tag_string)
  end

  def check_article_owner
    unless current_user.id == @article.user_id
      flash[:alert] = "この操作を行う権限がありません。"
      redirect_to article_path(@article) and return
    end
  end
end
