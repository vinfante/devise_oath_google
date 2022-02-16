module Api::V1::ApiHelper
  class Authenticator

    def initialize(google_client_id)
      @google_client_id = google_client_id
    end

    def valid_credentials?(token: nil, domain: nil)
      if token
        validator = GoogleIDToken::Validator.new
        begin
          @payload = validator.check(token, @google_client_id)
          if domain
            if proper_domain?(payload: @payload, domain: domain)
              true
            else
              false
            end
          else
            true
          end

        rescue GoogleIDToken::ValidationError => e
          p '---------------------error'
          p e
          p 'error---------------------'
          false
        end
      else
        false
      end
    end

    def get_payload
      @payload
    end

    private
    def proper_domain?(payload: nil, domain: nil)
      if !payload && !domain
        payload['email'].ends_with? domain
      else
        false
      end
    end
  end
end
