module Payments
  class Webhooks
  	def initialize(key)
  	  raise ArgumentError, 'Secret key must be set' unless key
  	  @key = key
  	end

  	def call(params)
      return "Test passed" if params.dig(:test) == true

  	  if sign_correct?(params)
       return params
      else
      	return "Errore #{params}"
      end
  	end
    
    private 

    def sign_correct?(params)
      sign_fields = "#{params.dig(:payment, :sum, :currency)}|#{params.dig(:payment, :sum, :amount)}|#{params.dig(:payment, :type)}|#{params.dig(:payment, :account)}|#{params.dig(:payment, :txnId)}"
      secret_key = Base64.decode64(@key)
      secure_hash = OpenSSL::HMAC.hexdigest('SHA256', secret_key, sign_fields)
      params[:hash] == secure_hash
    end

  end
end
