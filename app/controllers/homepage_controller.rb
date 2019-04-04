class HomepageController < ApplicationController
  def home
  end

  def create_user
    api_call = HTTParty.get("https://api.github.com/users/#{user_params['username']}")

    if api_call.code == 404
      puts 'Error: invalid username'
    else
      @api_response = JSON.parse(api_call.body)
      if user_exists
        @user = User.new(api_params)
        if @user.save
          flash[:success]= "Success: User saved."
          redirect_to root_path
        else
          flash[:alert] = "Error: User could not be saved."
          redirect_to root_path
        end
      else
        flash[:error] = "Error: Existing user."
        redirect_to root_path
      end
    end
  end

  private
  def user_params
    params.permit(:username)
  end

  def api_params
    api_params = ActionController::Parameters.new(@api_response)
    api_params['gh_id'] = api_params['id']
    api_params.delete('id')
    api_params.permit(:login,
                      :gh_id,
                      :type,
                      :name,
                      :company,
                      :blog,
                      :location,
                      :email,
                      :hireable,
                      :bio,
                      :public_repos,
                      :public_gists,
                      :followers,
                      :following)
  end

  def user_exists
    User.where(gh_id: api_params['gh_id']).empty?
  end
end
