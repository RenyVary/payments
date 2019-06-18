module Payments
  class HookCreator
    attr_reader :token, :address

    def initialize(hash = {token: "", address: ""})
      @token = hash[:token]
      @address = hash[:address]
    end

   def register
    uri = URI("https://edge.qiwi.com/payment-notifier/v1/hooks")
    encoded_query = URI.encode_www_form({hookType: 1, param: "#{@address}", txnType: '2'})
    uri.query = encoded_query

    put_request = Net::HTTP::Put.new(uri)
    res = request(uri, put_request)
    hook_id = get_result(res)
    hook_id["hookId"]
    end

    def create_key(hook_id)
      uri = URI("https://edge.qiwi.com/payment-notifier/v1/hooks/#{hook_id}/key")
      request = Net::HTTP::Get.new(uri)
      key = get_result(request(uri, request))
      key["key"]
    end

    def change_key(hook_id)
      uri = URI("https://edge.qiwi.com/payment-notifier/v1/hooks/#{hook_id}/newkey")
      request = Net::HTTP::Post.new(uri)
      new_key = get_result(request(uri, request))
      new_key["key"]
    end

    def delete_hook(hook_id:)
      uri = URI("https://edge.qiwi.com/payment-notifier/v1/hooks/#{hook_id}")
      request = Net::HTTP::Delete.new(uri)
      result = get_result(request(uri, request))
      result["response"]
    end

    private

    def get_result(response)
      if response.class == Net::HTTPOK
        accept_hash = JSON.parse(response.body)
      elsif response.class == Net::HTTPUnauthorized
        response.message
      else 
        "Undefinde error"
      end
    end
    
    def request(uri, request)
      request.initialize_http_header({"Authorization" => "Bearer #{@token}", "Content-Type" => "application/json"})
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      result = http.request(request)
    end
  end
end