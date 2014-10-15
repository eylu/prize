class MainController < ApplicationController
  skip_before_filter :admin_auth, :only => [:login, :logout]
  def index
    render :text => 'Hello'
  end
  def login
    if request.post?
      @admin = Admin.authenticate(params[:user][:name],params[:user][:password])
      if @admin.present?
        session[:admin_id] = @admin.id
        redirect_to(users_path)
      end
    end
  end
  def logout
    session[:admin_id] = nil
    reset_session
    redirect_to(login_path)
  end
end