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
  
  it "multiplex one to one" do
    a = Channel(Int32).new
    b = Channel(Int32).new
    Channels.multiplex([a],b)
    true.should eq test_channel_pair(a,b)
  end
  
  it "multiplex many to one" do
    inputs = Array(Channel(Int32)).new(4){ Channel(Int32).new }
    output = Channel(Int32).new
    Channels.multiplex(inputs,output)
    
    spawn do
      index = rand(inputs.size)
      (1..1000).each { |i| inputs[index].send i }
      inputs.each { |input| input.close }
    end
    
    (1..1000).each do |i|
      true.should eq(i == output.receive)
    end
  end
  
  it "tee one to one" do
    a = Channel(Int32).new
    b = Channel(Int32).new
    Channels.tee(a,[b])
    true.should eq test_channel_pair(a,b)
  end
  
  it "tee one to many" do
    input = Channel(Int32).new    
    outputs = Array(Channel(Int32)).new(4){ Channel(Int32).new }
    Channels.tee(input, outputs)
    
    spawn do
      (1..1000).each { |i| input.send i }
      input.close
    end
    (1..1000).each do |i|
      outputs.each do |output|
        true.should eq(i == output.receive)
      end
    end
  end
end
