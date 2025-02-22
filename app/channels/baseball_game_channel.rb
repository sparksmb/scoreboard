class BaseballGameChannel < ApplicationCable::Channel
  def subscribed
    stream_for "baseball_game"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
