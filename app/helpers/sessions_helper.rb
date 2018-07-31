module SessionsHelper

  # Logs in the given user
  # The session method automatically encrypts the user id
  def log_in (user)
    session[:user_id] = user.id
  end

  # Logs out the current user
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # Returns the current logged-in user (if any)
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Returns true if the user is logged in or false otherwise
  def logged_in?
    !current_user.nil?
  end
end
