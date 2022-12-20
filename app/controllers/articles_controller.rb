class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    set_article
  end

  def destroy
    article = Article.find(params[:id])
    if article.destroy
      flash[:success] = 'The article was successfully deleted'
      redirect_to root_path
    else
      flash.now[:danger] = 'There was a problem deleting the article :('
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      flash[:success] = 'The article was successfully uploaded'
      redirect_to @article
    else
      flash.now[:danger] = 'There was a problem uploading the article :('
      render new_article_path
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, :author)
  end
end
