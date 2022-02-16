class ApiController < ApplicationController
  before_action :set_default_format, :init_vars

  private 

  def set_default_format
    request.format = :json
  end

  def init_vars
    @token = nil
    bearer_pattern = /^Bearer /

    authorization_header = request.headers["Authorization"]
    if authorization_header && authorization_header.match(bearer_pattern)
      @token = authorization_header.gsub(bearer_pattern, '')
    end
  end

  def render_unauthorized
    unauthorized_status_code = 401
    render template: 'api/v1/apps/error.json.jbuilder', 
          nothing: true, 
          status: unauthorized_status_code, 
          locals: { 
            status: unauthorized_status_code, 
            status_str: Rack::Utils::HTTP_STATUS_CODES[unauthorized_status_code]
          }
  end

  def authenticated_user?
    session_db = Session.find_by_token(@token)
    if @token.nil? || session_db.nil?
      render_unauthorized
    else
      
        authenticator = Api::V1::ApiHelper::Authenticator.new(ENV['GOOGLE_CLIENT_ID'])

        if !authenticator.valid_credentials?(token: @token)
          p '--------VALIDATION ERROR-----------'
          render_unauthorized
        end

    end
  end
end
