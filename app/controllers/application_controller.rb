class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  CATEGORIES = %w[album book movie]
  # before_action :find_user

  helper_method :current_user, :better_created_at

  def current_user
    session[:user_id]
  end
  
end
