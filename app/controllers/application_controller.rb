class ApplicationController < ActionController::Base
  protect_from_forgery
  around_filter :user_time_zone, if: :current_user

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end
  
  def login_required
    return true if current_user
    redirect_to root_path, :alert => "Must be logged in "
  end

private

  def user_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end
end
