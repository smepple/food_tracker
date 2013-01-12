class SessionsController < ApplicationController
  
  def new
  end

  def create
    @user = User.find_by_username(params[:username])

    if @user && @user.authenticate(params[:password])
      sign_in @user
      flash[:success] = "Welcome!"
      redirect_back_or user_path(@user)
    else
      flash.now[:error] = "Invalid username/password combination"
      render 'new'
    end
  end

  def destroy
    sign_out
    flash[:success] = "Come back soon!"
    redirect_to root_url
  end
end
