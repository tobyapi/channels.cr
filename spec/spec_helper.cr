require "spec"
require "../src/channels"


def test_channel(channel)
  spawn do
    (1..1000).each { |i| channel.send i }
    channel.close
  end
  
  (1..1000).each do |i|
     return false if i != channel.receive
  end
  true
end

def test_channel_pair(input, output)
  spawn do
    (1..1000).each { |i| input.send i }
    input.close
  end
  
  (1..1000).each do |i|
     return false if i != output.receive
  end
  true  
end