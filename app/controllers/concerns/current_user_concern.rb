module CurrentUserConcern
  extend ActiveSupport::Concern 

  included do 
    before_action :set_current_user
  end

  def set_current_user
    logger.info "Setting current User"
    logger.info "Session: #{session.inspect}"
    logger.info "Session user concern: #{session[:user_id]}"
    if session[:user_id]
      logger.info "session user"
      @current_user = User.find(session[:user_id])
    end
  end
end