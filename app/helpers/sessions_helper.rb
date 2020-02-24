module SessionsHelper
  def sign_in(user)
    session[:user_id] = user.id
    remember user
    retriving_current_user
    setting_current_user
  end

  def logged_in
    !current_user.nil?
  end

  def check_log_in
    return nil unless retriving_current_user.nil? || setting_current_user.nil?

    flash[:danger] = 'You need to login first.'
    redirect_to signin_path
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def retriving_current_user
    if (user_id = session[:user_id])
      @current ||= User.find_by(id: user_id)
    end
  end

  def setting_current_user
    if (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      @current = user if user&.authenticated(cookies[:remember_token])
    end
  end

  def current_user
    if (user_id = session[:user_id])
      @current ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      @current = user if user&.authenticated(cookies[:remember_token])
    end
  end

  def forget?
    update_attribute(:remember_digest, nil)
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def sign_out(_user)
    forget(current_user)
    session.delete(:user_id)
    @current = nil
  end
end
