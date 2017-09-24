module Channels
  extend self
  
  def pipe(input : Channel(A), output : Channel(A), close_when_done : Bool = true) forall A
    spawn do
      while elem = input.receive
        output.send elem
      end
      output.close if close_when_done
    end
  end
end