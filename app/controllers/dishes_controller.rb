class DishesController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :show]

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
  end

  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in"
      end
    end
end
