class ArticlesController < ApplicationController
  before_action :set_article, only: [ :show, ]
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  def index
   @articles = Article.all
  end

  def show
    @comments = @article.comments
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to article_path(@article), notice: '保存できたよ'
    else
      flash.now[:error] = '保存できなかったよ'
      render :new
    end
  end

  def edit
    @article = current_user.articles.find(params[:id])
  end

  def update
    @article = current_user.articles.find(params[:id])
    @article.update(article_params)
    if @article.update(article_params)
      redirect_to article_path(@article), notice: '更新できました'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end
  end

  def destroy
    article = current_user.articles.find(params[:id])
    article.destroy!
    redirect_to root_path, status: :see_other, notice: '削除に成功しました'
  end

  def destroy
    article = Article.find(params[:article_id])
    like = article.likes.find_by(user_id: current_user.id)
    like.destroy!
    redirect_to article_path(article), notice: 'いいねを取り消しました'
  end


private
  def article_params
    params.require(:article).permit(:title, :content, :eyecatch)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
