class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    # debugger
    if @user&.authenticate(params[:session][:password])
      log_in @user
      current_user
      remember @user
      redirect_to posts_new_url
    else
      flash.now[:danger] = 'invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out @user
    redirect_to signin_path
  end
end
