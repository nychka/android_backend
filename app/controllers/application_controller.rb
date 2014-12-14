class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :available_locales

  private
  def available_locales;  [:en, :ua] ; end
  # def current_user
  #   @current_user ||= User.find(session[:user_id]) if session[:user_id]
  # end
  # def authenticate_user!
  #   redirect_to root_path, :notice => 'Only for authenticated users' unless current_user
  # end
end
