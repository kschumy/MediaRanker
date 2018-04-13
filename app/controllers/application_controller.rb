class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  CATEGORIES = %w[movie book album]
  # before_action :find_user

  helper_method :current_user

  def current_user
    session[:user_id]
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end

end
