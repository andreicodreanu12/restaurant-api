class MenuChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from 'menu_channel'
    debugger
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
