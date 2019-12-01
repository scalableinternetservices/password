class NetworkChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "network_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end