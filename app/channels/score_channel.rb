class ScoreChannel < ApplicationCable::Channel
  def subscribed
    stream_for "scoreboard"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
