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
    ap "===== ACTION: #{update_params[:action]} =============================="

    action = update_params.delete(:action)
    update_params = @game.compute_action(action, update_params) if action.present?

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
end
