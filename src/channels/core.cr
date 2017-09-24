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
  
  def multiplex(inputs : Array(Channel(A)), output : Channel(A), close_when_done : Bool = true) forall A
    spawn do
      finish = Channel(Bool).new
      inputs.each do |input|
        spawn do
          while elem = input.receive
            output.send elem
          end
          finish.send true if close_when_done
        end
      end

      if close_when_done
        count = 0
        while count < inputs.size
          count += 1 if finish.receive
        end
        output.close
      end
    end
  end
end