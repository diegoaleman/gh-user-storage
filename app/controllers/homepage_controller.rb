class HomepageController < ApplicationController
  def home
  end

  def create_user
  end

  private
  def user_params
    params.permit(:username)
  end
end
