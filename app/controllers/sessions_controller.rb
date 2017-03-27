class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "Log in succeeded"
      log_in(user)
      redirect_to root_url
    else
      flash.now[:danger] = "Invalid name or password"
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
