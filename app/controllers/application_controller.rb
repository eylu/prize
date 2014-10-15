class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :admin_auth

  def admin_auth
    @admin = login_admin
    unless @admin.present?
      redirect_to(login_path)
    end
  end

  def login_admin
    if session[:admin_id].present?
      Admin.find(session[:admin_id])
    end
  end
end
