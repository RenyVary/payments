require "spec_halper"
RSpec.describe Payments::Webhooks do
  
  it "missing key" do
    expect{described_class.new}.to raise_error ArgumentError
  end
 
end