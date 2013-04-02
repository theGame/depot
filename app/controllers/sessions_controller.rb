class SessionsController < ApplicationController
    skip_before_filter :autorize
  def new
  end

  def create
    user = User.find_by_name(params[:name])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_url
    else
      redirect_to login_url, alert: "Name and password is not curent!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_url, notice: "Session completion"
  end
end
