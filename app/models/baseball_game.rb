class BaseballGame < ApplicationRecord
  after_update_commit -> { broadcast_update }

  def broadcast_update
    BaseballGameChannel.broadcast_to("baseball_game", {
      html: ApplicationController.render(partial: "baseball_games/scoreboard", locals: { game: self })
    })
  end
end
