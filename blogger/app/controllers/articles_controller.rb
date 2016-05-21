class ArticlesController < ApplicationController
  include ArticlesHelper
  before_filter :require_login, except: [:index, :show]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.author = current_user.username
    @article.email = current_user.email
    @article.save
    flash.notice = "Article '#{@article.title}' Created!"
    redirect_to article_path(@article)
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)

    flash.notice = "Article '#{@article.title}' Updated!"

    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:id])
    flash.notice = "Article '#{@article.title}' Deleted!"
    @article.destroy
    redirect_to articles_path
  end

  def show
    @article = Article.find(params[:id])
    @article.view_count += 1
    @article.save
    @comment = Comment.new
    @comment.article_id = @article.id
    @current_user = current_user
  end

  private
    
    def require_login
      unless current_user
        flash.notice = "You must be logged in to perform this action."
        redirect_to :back
      end
    end
end
