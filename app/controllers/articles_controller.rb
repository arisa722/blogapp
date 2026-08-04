class ArticlesController < ApplicationController
  def index
   @article = Article.first
  end

  def about
  end
end