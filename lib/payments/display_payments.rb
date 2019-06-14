module Payments
  class DisplayPayments
    attr_reader :token, :wallet, :number, :operation

    def initialize(params = {token: "", wallet: ""})
      @token = params[:token]
      @wallet = params[:wallet]
    end

    def call(number: "10", operation: "ALL")
      uri = URI("https://edge.qiwi.com/payment-history/v2/persons/#{@wallet}/payments?rows=#{number}&operation=#{operation}") 
      
      get_result(make_request(uri))
    end 

    private

    def make_request(uri)
      response = nil
      Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Get.new uri
        request["Accept"] = "application/json"
        request["Content-Type"] = "application/json"
        request["Authorization"] = "Bearer #{@token}"
        response = http.request(request)
      end
    end

    def get_result(response)
      if response.class == Net::HTTPOK
        accept_hash = JSON.parse(response.body)
        make_arr(accept_hash)
      elsif response.class == Net::HTTPUnauthorized
        response.message
      else 
        "Undefinde error"
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