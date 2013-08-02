class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		redirect_to root_url, :notice => 'Sign up successful!'
  	else
  		render 'new'
  	end
  end

  def user_params
    params.require(:user).permit(:name, :user)
  end

  def user_authentication
    params.require(:authentication).permit(:provider, :secret, :token, :uid, :user_id)
  end

end
