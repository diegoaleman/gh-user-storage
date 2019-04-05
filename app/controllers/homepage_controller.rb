class HomepageController < ApplicationController
  def home
  end

  def create_user
    @api_call = get_api_call(user_params['username'])

    if @api_call.code == 200
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
    else
      flash[:error]= "Error: Non existing user."
      redirect_to root_path
    end
  end

  def update_user(username)
    @api_call = get_api_call(username)

    if @api_call.code == 200
      user = User.where(login: username).first
      old_params = user.attributes.slice(*user_attributes)
      new_params = api_params

      if old_params == new_params
        puts "User #{username} has no updates"
      else
        if user.update(new_params)
          puts "User #{username} was updated"
        else
          puts "Error updating #{username} attributes"
        end
      end
    else
      puts "Error fetching user: #{username}"
    end
  end

  private

  def get_api_call(username)
    HTTParty.get("https://api.github.com/users/#{username}")
  end

  def user_params
    params.permit(:username)
  end

  def user_attributes
    ["login","gh_id","type","name","company","blog","location","email","hireable","bio","public_repos","public_gists","followers","following"]
  end

  def api_params
    api_json = JSON.parse(@api_call.body)
    api_json['gh_id'] = api_json['id']
    api_json.delete('id')
    api_json.slice(*user_attributes)
  end

  def user_exists
    User.where(gh_id: api_params['gh_id']).empty?
  end
end
