class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :admin_signed_in?

  protected

  def admin_signed_in?
    current_user.try(:admin)
  end

  def only_admin!
    redirect_to new_user_session_path unless admin_signed_in?
  end

  def after_sign_in_path_for(resource)
    admin_signed_in? ? admin_root_path : root_path
  end
end
