module Channels
  class RingChannel(T) < Channel::Buffered(T)   
    def send(value : T)
      @queue.shift? if full? 
      previous_def send value
    end
  end
end