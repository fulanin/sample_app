module SessionsHelper

  # Logs in the given user
  # The session method automatically encrypts the user id
  def log_in (user)
    session[:user_id] = user.id
  end

  # Remembers a user in a persistent session
  def remember(user)
    user.remember

    # The cookies method is treated as a hash, which consists in a value and an expires fields
    # Setting a cookie that expires in 20.years.from_now is so common in rails that the cookies.pormanent method already does that
    # The .signed method encrypts the cookie before placing it on the browser
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Forgets a persistent session
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end


  # Logs out the current user
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # Returns the current logged-in user (if any)
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if (user && user.authenticated?(cookies[:remember_token]))
        log_in user
        @current_user = user
      end
    end
  end

  # Returns true if the user is logged in or false otherwise
  def logged_in?
    !current_user.nil?
  end
end
