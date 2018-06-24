module Channels
  class RingChannel(T) < Channel::Buffered(T)
    def initialize(capacity)
      super(capacity)
    end

    def send(value : T)
      @queue.shift if full?

      raise_if_closed
      @queue << value
      Scheduler.enqueue @receivers
      @receivers.clear

      self
    end
  end
end