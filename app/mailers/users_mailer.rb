class UsersMailer < ApplicationMailer
  def invite_user
    email = params[:email]
    @url = "#{ENV['BASE_ADDRESS']}/signup"

    mail(to: email, subject: "WDR Invite!")
  end
end