require "spec_halper"
RSpec.describe Payments do
  it "has a version number" do
    expect(Payments::VERSION).not_to be nil
  end
end