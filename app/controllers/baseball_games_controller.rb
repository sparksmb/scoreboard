class BaseballGamesController < ApplicationController
  before_action :set_game, only: [ :show, :edit, :update ]

  def show
  end

  def edit
  end

  def update
    if @game.update(game_params)
      redirect_to edit_game_path(@game), notice: "Score updated!"
    else
      render :edit
    end
  end

  def scoreboard
    @game = BaseballGame.first # Assume one active game
  end

  private

  def set_game
    @game = BaseballGame.find(params[:id])
  end

  def game_params
    params.require(:game).permit(
      :home_score,
      :away_score,
      :inning,
      :outs
    )
  end
end
