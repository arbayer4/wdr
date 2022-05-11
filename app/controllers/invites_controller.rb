class InvitesController < ApplicationController
  def invite_players
    users = params["invites"]
    pp "users: #{users}"
    user_array = users.split(',')
    user_array.each do |user|
      user_invite = Invite.where(email: user).first_or_initialize(invited_on: DateTime.now)
      user_invite.save
      UsersMailer.with(email: user).invite_user.deliver_later
    end
    render json: {success: "success"}
  end
end
