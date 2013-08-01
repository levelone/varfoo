class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # before_filter :authenticate

  helper_method :current_user
  # helper_method :logged_in

  private

  # def logged_in_as_admin
  #   session[:admin_id]
  # end

  # def logged_in_as_user
  #   session[:user_id].present?
  # end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin
    @current_user ||= Admin.find(session[:admin_id]) if session[:admin_id]
  end


  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
end