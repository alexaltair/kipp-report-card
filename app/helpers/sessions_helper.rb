module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token #from User Model
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by_remember_token(remember_token)
  end

  def current_user?(user)
    user == current_user
  end

  # Authorization: signed_in_user is called in a before_filter, callback in other controllers
  # Ensures access to create/edit functions on if signed in.
  def signed_in_user
    unless signed_in?
      store_location #friendly forwarding, method from sessions_helper to remember url they were trying to go to
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def sign_out
    @current_user = nil
    cookies.delete(:remember_token)
  end

  #friendly forwarding stuff
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end

  def admin?
    current_user.admin
  end

  def active?
    current_user.active
  end

end
