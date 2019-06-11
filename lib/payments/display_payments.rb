require 'json'
require 'net/http'
module Payments
  class DisplayPayments
    attr_reader :token, :wallet, :number, :operation

    def initialize(params = {token: "", wallet: ""})
      @token = params[:token]
      @wallet = params[:wallet]
    end

    def call_payments(number: "10", operation: "ALL")
      uri = URI("https://edge.qiwi.com/payment-history/v2/persons/#{@wallet}/payments?rows=#{number}&operation=#{operation}") 

      response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        request = Net::HTTP::Get.new uri
        request["Accept"] = "application/json"
        request["Content-Type"] = "application/json"
        request["Authorization"] = "Bearer #{@token}"

        http.request(request)
      end
      if response.class == Net::HTTPOK
        accept_hash = JSON.parse(response.body)
        make_arr(accept_hash)
      else
        "nil"
      end
    end 

    def make_arr(accept_hash)
      result = []
      accept_hash["data"].each do |hash|
        h = {}
        h[:date] = hash["date"]
        h[:amount] = hash["total"]["amount"]  
        h[:comment] = hash["comment"]
        h[:payer_account] = hash["account"]
        result << h
      end
      result
    end
  end
end