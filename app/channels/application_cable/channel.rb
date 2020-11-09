module ApplicationCable
  class Channel < ActionCable::Channel::Base
    def subscribed
      stream_for 'menu_item'
    end

    def unsubscribed
    end
  end
end
