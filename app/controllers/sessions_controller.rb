class SessionsController < ApplicationController
  include CurrentUserConcern
  def create
    user = User.where(email: params["user"]["email"]).first
    .try(:authenticate, params["user"]["password"])
    logger.info "User: #{user.inspect}"
    if user
      session[:user_id] = user.id
      logger.info "session 2: #{session.inspect}"
      render json: {
        status: :created,
        logged_in: true,
        user: user
      }
    else
      render json: {status: 401}
    end
  end

  def logged_in
    if @current_user
      render json: {
        logged_in: true,
        user: @current_user
      }
    else
      render json: {
        logged_in: false
      }
    end
  end

  def logout
    reset_session
    render json: {status: 200, logged_out: true}
  end
end