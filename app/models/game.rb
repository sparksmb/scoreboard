class Game < ApplicationRecord
  after_update_commit -> { broadcast_update }

  def broadcast_update
    ScoreChannel.broadcast_to("scoreboard", {
      html: ApplicationController.render(partial: "games/scoreboard", locals: { game: self })
    })
  end
end
