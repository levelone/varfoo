class SessionsController < ApplicationController
	def new
	end

	def create
    # callback_data = request.env['omniauth.auth']
    # authentication = Authentication.where(:uid => callback_data[:uid], :provider => callback_data[:provider]).first

    # if ['marcseifert'].include? callback_data[:extra][:raw_info][:screen_name]
    #   if authentication.present?
    #     user = authentication.user
    #     user.update_attributes(:name => callback_data[:info][:name])
    #     authentication.update_attributes(
    #       :token => callback_data[:credentials][:token],
    #       :secret => callback_data[:credentials][:secret]
    #     )
    #   else
    #     user = User.create(:name => callback_data[:info][:name])
    #     user.authentications.create(
    #       :uid => callback_data[:uid],
    #       :provider => callback_data[:provider],
    #       :token => callback_data[:credentials][:token],
    #       :secret => callback_data[:credentials][:secret]
    #     )
    #   end

    #   current_user.admin == true
    #   session[:user_id] = user.id # Sign the user in
    #   redirect_to root_url, :notice => "Logged in!"
    # else
    #   redirect_to root_url, :notice => "Not so clever!"
    # end



    # user = User.from_omniauth(env["omniauth.auth"])
    # session[:user_id] = user.id
    # redirect_to root_url, notice: "Signed in!"

	  user = User.authenticate(params[:name], params[:password])
	  if user
	    session[:user_id] = user.id
	    redirect_to root_url, :notice => "Logged in!"
	  else
	    flash.now.alert = "Invalid name or password"
	    render :new 
	  end
	end

	def destroy
	  session[:user_id] = nil
	  redirect_to root_url, :notice => "Logged out!"
	end
end