require "spec_halper"
RSpec.describe Payments::DisplayPayments do
  describe "call_payments" do
  	context "when returns payments with data" do
  	  before do
  	  	@obj = Payments::DisplayPayments.new(token: "638107c0d9d6396728dc9786c77ed4c5", wallet: "77051698108") 
  	  end
      it "with operation ALL" do
         stub_request(:get, "https://edge.qiwi.com/payment-history/v2/persons/77051698108/payments?operation=ALL&rows=10").
         with(
          headers: {
            'Accept'=>'application/json',
            'Authorization'=>'Bearer 638107c0d9d6396728dc9786c77ed4c5',
            'Content-Type'=>'application/json',
            'Host'=>'edge.qiwi.com',
            'User-Agent'=>'Ruby'
          }).
        to_return(body: File.new('spec/payments/fixtures/payments.json'))

        expect(@obj.call[0]).to include(:date, :amount, :comment, :payer_account)
      end

      it "returns payments IN" do
        stub_request(:get, "https://edge.qiwi.com/payment-history/v2/persons/77051698108/payments?operation=IN&rows=10").
         with(
          headers: {
            'Accept'=>'application/json',
            'Authorization'=>'Bearer 638107c0d9d6396728dc9786c77ed4c5',
            'Content-Type'=>'application/json',
            'Host'=>'edge.qiwi.com',
            'User-Agent'=>'Ruby'
          }).
        to_return(body: File.new('spec/payments/fixtures/payments.json'))
        expect(@obj.call(operation: "IN")[0]).to include(:date, :amount, :comment, :payer_account)
      end

      it "returns payments OUT" do
         stub_request(:get, "https://edge.qiwi.com/payment-history/v2/persons/77051698108/payments?operation=OUT&rows=10").
         with(
          headers: {
            'Accept'=>'application/json',
            'Authorization'=>'Bearer 638107c0d9d6396728dc9786c77ed4c5',
            'Content-Type'=>'application/json',
            'Host'=>'edge.qiwi.com',
            'User-Agent'=>'Ruby'
          }).
        to_return(body: File.new('spec/payments/fixtures/payments.json'))
        expect(@obj.call(operation: "OUT")[0]).to include(:date, :amount, :comment, :payer_account)
      end

       it "returns a certain amount of payments " do
         stub_request(:get, "https://edge.qiwi.com/payment-history/v2/persons/77051698108/payments?operation=ALL&rows=20").
         with(
          headers: {
            'Accept'=>'application/json',
            'Authorization'=>'Bearer 638107c0d9d6396728dc9786c77ed4c5',
            'Content-Type'=>'application/json',
            'Host'=>'edge.qiwi.com',
            'User-Agent'=>'Ruby'
          }).
        to_return(body: File.new('spec/payments/fixtures/payments.json'))
        expect(@obj.call(number: "20")[0]).to include(:date, :amount, :comment, :payer_account)
      end
    end

    context "dont returns paymnets" do
      it "when dont accepted token" do
        stub_request(:get, "https://edge.qiwi.com/payment-history/v2/persons/77051698908/payments?rows=10&operation=ALL").
         with(
          headers: {
            'Accept'=>'application/json',
            'Authorization'=>'Bearer 638107c0d9d6396728dc9786c77ed4u6',
            'Content-Type'=>'application/json'
          }).
        to_return(status: [401, 'Unauthorized'])
        obj = Payments::DisplayPayments.new(token: "638107c0d9d6396728dc9786c77ed4u6", wallet: "77051698908").call
        puts obj
        expect(obj).to eq("Unauthorized")
      end

      it "when dont accepted wallet" do
        stub_request(:get, "https://edge.qiwi.com/payment-history/v2/persons/77051698988/payments?rows=10&operation=ALL").
         with(
          headers: {
            'Accept'=>'application/json',
            'Authorization'=>'Bearer 638107c0d9d6396728dc9786c77ed4c5',
            'Content-Type'=>'application/json'
          }).
        to_return(status: [401, 'Unauthorized'])
        obj = Payments::DisplayPayments.new(token: "638107c0d9d6396728dc9786c77ed4c5", wallet: "77051698988").call
        puts obj
        expect(obj).to eq("Unauthorized")
      end
    end
  end
end