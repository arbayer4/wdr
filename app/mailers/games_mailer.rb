class GamesMailer < ApplicationMailer

  def confirm_player
    pp "in mailer"
    @user = params[:user]
    @game = params[:game]

    @order =@user["order"].to_i
    @status = @order < 16 ? "Confirmed" : "Waitlisted"
  
    

    mail(to: @user["email"], subject: @game['date'].strftime("Thanks for signing up for WDR on %a %-m/%-d"))
  end

  def confirm_cancel_reservation
    @user = params[:user]
    @game = params[:game]

    mail(to: @user["email"], subject: @game['date'].strftime("Your WDR reservation cancelled for %a %-m/%-d"))
  end

  def upgraded_reservation
    @user = params[:user]
    @game = params[:game]

    mail(to: @user["email"], subject: @game['date'].strftime("You're in! WDR on %a %-m/%-d"))
  end
end
