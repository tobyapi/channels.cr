require "./spec_helper"

include Channels

describe Channels do
  it "balck hole" do
    black_hole = BlackHole(Int32).new
      
    (1..1000).each do |i|
      black_hole.send i
    end
      
    true.should eq(1000 == black_hole.size)
  end
end