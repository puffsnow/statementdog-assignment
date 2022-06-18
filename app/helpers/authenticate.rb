module Authenticate
  def authenticate!
    user_session = UserSession.find_by(token: auth_token) if auth_token.present?
    redirect_to users_path if user_session.nil? || user_session.expired?
    @current_user = user_session.user
  end

  def current_user
    @current_user
  end

  def auth_token
    session['auth_token']
  end
end
