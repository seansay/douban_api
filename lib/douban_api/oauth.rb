# -*- encoding : utf-8 -*-
module Douban
  # Defines HTTP request methods
  module OAuth
    # Return URL for OAuth authorization
    def authorize_url(options={})
      options[:response_type] ||= "code"
      params = access_token_params.merge(options)
      connection.build_url("https://www.douban.com/service/auth2/auth", params).to_s
    end

    # Return an access token from authorization
    def get_access_token(code, options={})
      options[:grant_type] ||= "authorization_code"
      params = access_token_params.merge(options)
      post("https://www.douban.com/service/auth2/token", params.merge(:code => code), raw=false)
    end

    def refresh(options={})
      options[:grant_type] ||= "refresh_token"
      params = access_token_params.merge(options)
      post("https://www.douban.com/service/auth2/token",
            params.merge(:refresh_token => refresh_token),
            raw=false)
    end
    
    private

    def access_token_params
      {
        :client_id => client_id,
        :client_secret => client_secret
      }
    end
  end
end
