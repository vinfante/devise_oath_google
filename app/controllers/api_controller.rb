class ApiController < ApplicationController
  before_action :set_default_format, :init_vars

  private 

  def set_default_format
    request.format = :json
  end

  def init_vars
    @token = params[:token]
  end

  def authenticated_user?
    session_db = Session.find_by_token(@token)
    if session_db.nil?
      render template: 'api/v1/apps/error.json.jbuilder', :nothing => true, :status => 401, locals: {status: 401}
    else
      begin
        # JWT.decode @token, hmac_secret, true, { algorithm: 'HS256' }
        JWT.decode @token, nil, false
      rescue JWT::ExpiredSignature
        render template: :error, :nothing => true, :status => 401
      end
    end
  end
end