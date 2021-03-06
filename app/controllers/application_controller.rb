class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  CATEGORIES = %w[album book movie]

  def current_user
    session[:user_id]
  end

end
