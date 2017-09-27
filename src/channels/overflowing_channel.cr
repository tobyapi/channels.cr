module Channels
  class OverflowingChannel(T) < Channel::Buffered(T)    
    def send(value : T)
      previous_def value unless full?
    end
  end
end