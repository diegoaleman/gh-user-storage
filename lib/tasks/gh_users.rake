namespace :gh_users do
  desc "Requests user data of all users and updates if needed"

  task :update_users => :environment do
    homepage_controller = HomepageController.new

    User.all.each do |user|
      homepage_controller.update_user user.login
    end
  end
end
