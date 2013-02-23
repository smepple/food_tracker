class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:show]
  before_filter :correct_user, only: [:show]
  before_filter :non_signed_in_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Thanks for signing up!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in"
      end
    end

    def non_signed_in_user
      redirect_to current_user, notice: "You're already signed up" if signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to current_user, notice: "You don't have permission to access this page" unless current_user?(@user)
    end
end
