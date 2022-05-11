class GamesController < ApplicationController 
  include CurrentUserConcern


  def get_games
    today = DateTime.current
    games = Game.where('date > ?', today)
    formatted_games = games.map do |game|
      game_object = game.as_json
      gamePlayers = game.game_users.order(:signed_up_at)
      pp gamePlayers
      players = gamePlayers.map do |gp|
        user = User.find(gp.user_id)
        pp user
        user_hash = user.as_json
        user_hash["order"] = gp.order
        user_hash
      end
      pp players
      game_object["players"] = players
      game_object

    end
    
    render json: formatted_games
  end

  def add_player_to_game
    if @current_user
      game_id = params["game_id"]
      player_id = params["player_id"]

      game = Game.find(game_id)
      new_reservation = GameUser.where(game_id: game_id, user_id: player_id).first_or_initialize(signed_up_at: DateTime.now)
      new_reservation.save
      pp "Player added: #{new_reservation.inspect}"

      game_players = adjust_order(game_id)
      pp "game players: #{game_players.inspect}"
      pp "player_reservation: #{new_reservation.inspect}"
      player = User.find(player_id)
      player = player.as_json
      player["order"] = game_players.select{|gp| gp.user_id == player_id}.first["order"]
      pp player

      pp "mailing"
      GamesMailer.with(user: player, game: game).confirm_player.deliver_later
      render json: {player: player}, :status => :ok
    else
      render json: {status: "forbidden"}

    end
  end

  def remove_player_from_game
    logger.info "Starting remove player"
    logger.info @current_user
    if @current_user
      logger.info "remove player1"
      game_id = params["game_id"]
      player_id = params["player_id"]

      player_reservation = GameUser.where(game_id: game_id, user_id: player_id,)
      game = Game.find(game_id)
      player = User.find(player_id)
      pp "Removing player: #{player_reservation.inspect}"
      # Email player deleted reservation
      GamesMailer.with(user: player, game: game).confirm_cancel_reservation.deliver_later if player
      player_reservation.delete_all

      game_players = adjust_order(game_id)
      if game_players.length >= 15
        upgraded_player = User.find(game_players[14]["user_id"])
        GamesMailer.with(user: upgraded_player, game: game).upgraded_reservation.deliver_later if upgraded_player
      end
      pp "game players: #{game_players.inspect}"
      render json: {player_id: player_id}, :status => :ok
    else
      logger.info "remove player2"
      render json: {status: "forbidden"}

    end
  end
  def add_games

    if @current_user
      dates = params["games"]
      games = []
      dates.each do |date|
        game = Game.create(date: date)
        game = game.as_json
        game["players"]=[]
        games << game
      end
      render json: {games_created: games}, :status => :ok
    else
      render json: {status: "forbidden"}

    end

    # pp params
    # render json: {status: "okay" }
    # games = params["games"]
  end

  private

  def adjust_order(game_id)
    reservations = GameUser.where(game_id: game_id).order(:signed_up_at)
    order = 1
    updated_order = reservations.map do |reservation|
      reservation["order"] = order
      reservation.save
      order+=1
      reservation
    end
  end
end

