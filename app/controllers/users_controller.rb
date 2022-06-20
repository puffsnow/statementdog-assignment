class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def become
    user = User.find(params[:id])
    user_session = UserSession.create(user: user)

    session['auth_token'] = user_session.token

    redirect_to detect_lists_path
  end
end
