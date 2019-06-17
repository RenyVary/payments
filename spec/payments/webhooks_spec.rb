require "spec_halper"
RSpec.describe Payments::Webhooks do
  
  it "missing key" do
    expect{described_class.new}.to raise_error ArgumentError
  end

 describe 'when webhook ' do
 	webhook = Payments::Webhooks.new("PyzfYVEiLdcKLdZ9ysjzagyxlSgY9SLpL4BTUupBQho=")
	  it 'is test = true' do
	    params = {
	      messageId: "7814c49d-2d29-4b14-b2dc-36b377c76156",
	      hookId: "5e2027d1-f5f3-4ad1-b409-058b8b8a8c22",
	      payment: {
	        txnId: "13353941550",
	        date: "2018-06-27T13:39:00+03:00",
	        type: "IN",
	        status: "SUCCESS",
	        errorCode:"0",
	        personId: 78000008000,
	        account: "+79165238345",
	        comment:"",
	        provider:7,
	        sum: {
	          amount:1,
	          currency: 643
	        },
	        commission: {
	          amount: 0,
	          currency: 643
	        },
	        total: {
	          amount: 1,
	          currency: 643
	        },
	        signFields: "sum.currency,sum.amount,type,account,txnId"
	      },
	      hash: "76687ffe5c516c793faa46fafba0994e7ca7a6d735966e0e0c0b65eaa43bdca0",
	      version: "0.1.1",
	      test: true
	    }
	    expect(webhook.call(params)).to eq("Test passed")
	  end


	  it 'is sign_correct' do
	    params = {
	      messageId: "7814c49d-2d29-4b14-b2dc-36b377c76156",
	      hookId: "a1ca8046-0552-4a93-8060-4e81fe6945cb",
	      payment: {
	        txnId: "13353941550",
	        date: "2018-06-27T13:39:00+03:00",
	        type: "IN",
	        status: "SUCCESS",
	        errorCode:"0",
	        personId: 78000008000,
	        account: "+79165238345",
	        comment:"",
	        provider:7,
	        sum: {
	          amount:1,
	          currency: 643
	        },
	        commission: {
	          amount: 0,
	          currency: 643
	        },
	        total: {
	          amount: 1,
	          currency: 643
	        },
	        signFields: "sum.currency,sum.amount,type,account,txnId"
	      },
	      hash: "233b84733e37e59da242225c9aac410cd6bb05c4c71a9d4077dc51916de91320",
	      version: "0.1.1",
	      test: false
	    }
	    expect(webhook.call(params)).to eq(params)
	  end

	  it 'is sign incorrect' do
	    params = {
	      messageId: "7814c49d-2d29-4b14-b2dc-36b377c76156",
	      hookId: "a1ca8046-0552-4a93-8060-4e81fe6945cb",
	      payment: {
	        txnId: "13353941550",
	        date: "2018-06-27T13:39:00+03:00",
	        type: "IN",
	        status: "SUCCESS",
	        errorCode:"0",
	        personId: 78000008000,
	        account: "+79165238345",
	        comment:"",
	        provider:7,
	        sum: {
	          amount:1,
	          currency: 643
	        },
	        commission: {
	          amount: 0,
	          currency: 643
	        },
	        total: {
	          amount: 1,
	          currency: 643
	        },
	        signFields: "sum.currency,sum.amount,type,account,txnId"
	      },
	      hash: "76687ffe5c516c793faa46fafba0994e7ca7a6d735966e0e0c0b65eaa43bdca0",
	      version: "0.1.1",
	      test: false
	    }
	    expect(webhook.call(params)).to eq("Errore #{params}")
	  end
  end
end