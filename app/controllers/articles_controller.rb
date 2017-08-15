class ArticlesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_article, only: [:show, :edit, :update, :destroy]


  def index
    @articles = Article.all
  end

  def show
    @content = kramdown(@article.content)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.create(article_params)
    redirect_to article_path(@article)
  end

  def edit
  end

  def update
    @article = Article.update(article_params)
    redirect_to article_path(@article)
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def find_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end

  def kramdown(text)
    Kramdown::Document.new(text).to_html.html_safe
  end

end
