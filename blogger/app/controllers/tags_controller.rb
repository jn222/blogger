class TagsController < ApplicationController
  before_filter :require_login, only: [:destroy]
  def index
    @tags = Tag.all
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.delete
    redirect_to tags_path
  end

  def show
    @tag = Tag.find(params[:id])
  end

  private

    def require_login
      unless current_user
        return render(:nothing => true, :status => 204, :notice => "You must be logged in to perform this action.")
      end
    end
end
