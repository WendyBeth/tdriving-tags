class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_admin!
    unless current_user && current_user.admin?
      redirect_to new_user_session_path
    end
  end
end
