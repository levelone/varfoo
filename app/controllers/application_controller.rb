class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_filter :authenticate

  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  # def authenticate
  #   puts '-0-----------------'
  #   puts request.url
  #   authenticate_or_request_with_http_basic do |username, password|
  #     username == "foo" && password == "bar"
  #   end
  # end
end