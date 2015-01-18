class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :set_up_gon
  after_filter :clear_gon

  def set_up_gon
    env['action_controller.instance'] = self
  end

  def clear_gon
    Thread.current['gon'] = nil
  end

  def authenticate_admin!
    unless current_user && current_user.admin?
      flash[:alert] = "You do not have permission to access that page!"
      redirect_to new_user_session_path
    end
  end
end
