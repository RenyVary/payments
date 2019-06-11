require "spec_halper"
RSpec.describe Payments::DisplayPayments do
  describe "#call_payments" do
  	context "when returns payments with data" do
  	  before do
  	  	@obj = Payments::DisplayPayments.new(token: "638107c0d9d6396728dc9786c77ed4c5", wallet: "77051698108") 
  	  end
      it "returns payments ALL" do
        expect(@obj.call_payments[0]).to include(:date, :amount, :comment, :payer_account)
      end

      it "returns payments IN" do
        expect(@obj.call_payments(operation: "IN")[0]).to include(:date, :amount, :comment, :payer_account)
      end

      it "returns payments OUT" do
        expect(@obj.call_payments(operation: "IN")[0]).to include(:date, :amount, :comment, :payer_account)
      end

       it "returns a certain amount of payments " do
        expect(@obj.call_payments(number: "1")[0]).to include(:date, :amount, :comment, :payer_account)
      end
    end

    context "when dont accepted token or wallet" do
      it "dont returns paymnets" do
        expect(subject.call_payments).to eq("nil")
      end
    end
  end
end