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
    update_params = game_params.to_h

    ap "===== ACTION: #{update_params[:action]} =============================="
    case
    when homerun?
      new_score = @game.compute_score_from_home_run
      update_params["#{@game.batting_team}_score"] = new_score
    when ball?
      count = @game.next_ball_count
      update_params["balls"] = count
    end

    #ap "======================== AFTER LOGIC ================================"
    #ap update_params

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
      :action
    )
  end

  def homerun?
    game_params[:action] == "homerun"
  end

  def ball?
    game_params[:action] == "ball"
  end
end
