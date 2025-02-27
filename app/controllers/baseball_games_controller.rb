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
    ap update_params = game_params.to_h

    case
    when homerun?
      ap new_score = @game.compute_score_from_home_run(team: "home")
      update_params["home_score"] = new_score
    end

    ap "======================== AFTER LOGIC ================================"
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
      :home_run
    )
  end

  def homerun?
    params[:baseball_game][:home_run].present?
  end
end
