class StaticPagesController < ApplicationController
  def home
    redirect_to user_path(current_user) if signed_in?
  end
end
