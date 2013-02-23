class CommentsController < ApplicationController
  before_filter :signed_in_user

  def new
    @comment = Comment.new(dish_id: params[:dish_id], parent_id: params[:parent_id], user_id: current_user.id)
  end

  def create
    @comment = current_user.comments.create(params[:comment])

    respond_to do |format|
      format.html { redirect_to dish_path(@comment.dish_id) }
      format.js
    end
  end

  private

    def signed_in_user
      unless signed_in?
        redirect_to signin_url, notice: "Please sign in"
      end
    end
end
