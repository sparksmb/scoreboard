class BaseballGamesController < ApplicationController
  before_action :set_game, only: [ :show, :edit, :update ]

  def show
    render :scoreboard
  end

  def edit
  end

  def update
    if @game.update(game_params)
      redirect_to edit_baseball_game_path(@game), notice: "Score updated!"
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
      :outs
    )
  end
end
