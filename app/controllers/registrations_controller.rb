class RegistrationsController < ApplicationController 
  def create
   user = User.where(email: params['user']['email']).first
   pp user.inspect
   if user
    render json: { status: :conflict, reason: "Email already exists." }
   else
   invite = Invite.where(email: params['user']['email']).first
   invite.accepted_at = DateTime.now if invite
   invite.save if invite
    user = User.create(
      email: params['user']['email'],
      password: params['user']['password'],
      firstname: params['user']['first_name'] ,
      lastname: params['user']['last_name'] ,
      password_confirmation: params['user']['password'],
      verified: invite ? true : false
    )
    if user
      session[:user_id]=user.id
      render json: {
        status: :created,
        logged_in: true,
        user: user
      }
    else
      render json: { status: 500 }
    end
   end
  end
end