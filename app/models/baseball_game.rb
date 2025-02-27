class BaseballGame < ApplicationRecord
  attr_accessor :home_run

  after_update_commit -> { broadcast_update }

  def broadcast_update
    BaseballGameChannel.broadcast_to("baseball_game", {
      html: ApplicationController.render(partial: "baseball_games/scoreboard", locals: { game: self })
    })
  end

  def compute_score_from_home_run(team:)
    current_score = team == "home" ? home_score : away_score
    runners_scored = base_runner_count
    current_score + runners_scored + 1
  end

  def clear_count
    {
      balls: 0,
      strikes: 0,
      outs: 0
    }
  end

  def base_runner_count
    [
      runner_on_first,
      runner_on_second,
      runner_on_third
    ].count(true)
  end
end
