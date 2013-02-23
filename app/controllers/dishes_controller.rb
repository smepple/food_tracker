class DishesController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :show]
  respond_to :html, :json

  def new
    @user = current_user
    @dish = @user.dishes.new
  end

  def create
    @user = current_user
    @dish = current_user.dishes.new(params[:dish])

    if @dish.save
      flash[:success] = "Dish saved!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def show
    @dish = Dish.find(params[:id])
    @category = Category.find(@dish.category_id)
    @source = Source.find(@dish.source_id)
    @comments = @dish.comments
    @comment = Comment.new(dish_id: params[:id], user_id: current_user.id)
  end

  def update
    @dish = Dish.find(params[:id])
    @dish.update_attributes(params[:dish])
    respond_with_bip @dish
  end

  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in"
      end
    end
end
