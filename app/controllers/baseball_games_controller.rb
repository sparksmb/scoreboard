class BaseballGamesController < ApplicationController
  before_action :set_game, only: [
    :show,
    :edit,
    :update
  ]

  def show
    render :scoreboard
  end

  def edit
  end

  def update
    # ap game_params
    ap update_params = game_params.to_h

    ap "===== ACTION: #{update_params[:action]} =============================="
    case
    when homerun?
      new_score = @game.compute_score_from_homerun
      update_params["#{@game.batting_team}_score"] = new_score
      update_params["runner_on_first"] = false
      update_params["runner_on_second"] = false
      update_params["runner_on_third"] = false
    when ball?
      update_params["balls"] = @game.next_ball_count
    when strike?
      update_params["strikes"] = @game.next_strike_count
    when out?
      update_params["outs"] = @game.next_out_count
    when clear_count?
      update_params["balls"] = 0
      update_params["strikes"]  = 0
    when clear_all_counts?
      update_params["balls"] = 0
      update_params["strikes"]  = 0
      update_params["outs"]  = 0
    when walk?
      update_params["balls"] = 0
      update_params = @game.compute_walk(update_params)
    when inc_home_score?
      update_params["home_score"] = @game.home_score + 1
    when inc_away_score?
      update_params["away_score"] = @game.away_score + 1
    end

    ap update_params

    if @game.update!(update_params)
      redirect_to edit_baseball_game_path(@game)
    else
      flash[:alert] = "Error updating score."
      redirect_to edit_baseball_game_path(@game)
    end
  end

  def scoreboard
    # Need a better solution here
    @game = BaseballGame.first
  end

  private

  def set_game
    @game = BaseballGame.find(params[:id])
  end

  def game_params
    params.require(:baseball_game).permit(
      :home_score,
      :away_score,
      :inning,
      :inning_status,
      :balls,
      :strikes,
      :outs,
      :runner_on_first,
      :runner_on_second,
      :runner_on_third,
      :action
    )
  end

  def homerun?
    game_params[:action] == "homerun"
  end

  def ball?
    game_params[:action] == "ball"
  end

  def strike?
    game_params[:action] == "strike"
  end

  def out?
    game_params[:action] == "out"
  end

  def clear_count?
    game_params[:action] == "clear_count"
  end

  def clear_all_counts?
    game_params[:action] == "clear_all_counts"
  end

  def walk?
    game_params[:action] == "walk"
  end

  def inc_home_score?
    game_params[:action] == "inc_home_score"
  end

  def inc_away_score?
    game_params[:action] == "inc_away_score"
  end
end
