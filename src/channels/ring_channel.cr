module Channels
  class RingChannel(T) < Channel::Buffered(T)
    def send(value : T)
      @queue.shift? if @queue.full?      
      previous_def value
    end
  end
end