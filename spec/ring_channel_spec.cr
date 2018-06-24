require "./spec_helper"

include Channels

describe Channels do
  it "ring" do    
    ring_channel = RingChannel(Int32).new(10)
    (1..1000).each { |i| 
        #puts "#{i} #{ring_channel.full?}"
      ring_channel.send i }
    (991..1000).each do |i|
      true.should eq(i == ring_channel.receive)
    end
  end
end