require "./spec_helper"

describe Channels do
  # TODO: Write tests

  it "works" do
    false.should eq(true)
  end
  
  it "pipe" do
    a = Channel(Int32).new
    b = Channel(Int32).new
    Channels.pipe(a,b)
    true.should eq test_channel_pair(a,b)
  end
end
