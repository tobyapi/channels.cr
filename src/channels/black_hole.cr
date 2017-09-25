module Channels
  class BlackHole(T) < Channel(T)
    getter size : Int32

    def initialize
      super
      @size = 0
    end
    
    def send(value : T)
      @size += 1
    end

    private def receive_impl
      yield if @closed
      nil
    end
  end
end