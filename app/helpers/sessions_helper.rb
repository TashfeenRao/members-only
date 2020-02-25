module SessionsHelper
  def sign_in(user)
    user.remember
    cookies.permanent[:remember_token] = user.remember_token
    @current_user = user
  end

  def logged_in
    !current_user.nil?
  end

  def check_log_in
    return unless current_user.nil?
      flash[:danger] = 'You need to login first.'
      redirect_to signin_path
  end

  def current_user
    @current_user ||= User.find_by(remember_digest: User.digest(cookies[:remember_token]))
  end

  def current_user=(user)
    @current_user = user
  end

  def sign_out(_user)
    session[:user_id] = nil
    cookies[:remember_token] = nil
    @current_user = nil
  end
end
