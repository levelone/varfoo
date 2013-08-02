class SessionsController < ApplicationController
	def new
	end

	def create
    # User coming from login form
    if params[:'login-form'] == 'true'
      admin = Admin.authenticate(params[:name], params[:password])

      if admin
        session[:admin_id] = admin.id
        # current_user = true
        # puts current_user.present?
        redirect_to root_url, :notice => "Logged in!"
      else
        redirect_to log_in_path, :notice =>  "Invalid name or password"
        # render :new 
      end

    else

      # User coming from Twitter
      callback_data = request.env['omniauth.auth']
      authentication = Authentication.find_by(:uid => callback_data[:uid], :provider => callback_data[:provider])
      
      if ['marcseifert'].include? callback_data[:extra][:raw_info][:screen_name]
        if authentication.present?
          user = authentication.user
          user.update_attributes!(:name => callback_data[:info][:name])
          authentication.update_attributes(
            :token => callback_data[:credentials][:token],
            :secret => callback_data[:credentials][:secret]
          )
        else
          user = User.create!(:name => callback_data[:info][:name])
          user.authentications.create(
            :uid => callback_data[:uid],
            :provider => callback_data[:provider],
            :token => callback_data[:credentials][:token],
            :secret => callback_data[:credentials][:secret]
          )
        end
        
        puts 'fooooooooooo0000---------------'
        puts user.inspect
        puts env["omniauth.auth"]

        # user = User.from_omniauth(env["omniauth.auth"])
        session[:user_id] = user.id
        redirect_to root_url, notice: "Signed in!"
      else
        redirect_to root_url, :notice => "Not so clever!"
      end



  	  # admin = Admin.authenticate(params[:name], params[:password])
      # puts admin
  	  # if admin
  	  #   session[:user_id] = admin.id
  	  #   redirect_to root_url, :notice => "Logged in!"
  	  # else
  	  #   flash.now.alert = "Invalid name or password"
  	  #   # render :new 
  	  # end
    end
	end

	def destroy
    session.destroy
	  session[:admin_id] = nil
	  redirect_to root_url, :notice => "Signed out!"
	end
end