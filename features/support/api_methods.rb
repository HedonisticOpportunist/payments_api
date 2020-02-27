# frozen_string_literal: true

require 'uri'
require 'net/http'

# class to connect to api
class APIMethods
  def retrieve_token
    LOG.info('Retrieving the authentication token')
    api_url = URI(ENV['AUTH_SERVICE'])
    api_request = connect_to_url(api_url)
    api_request['Content-Type'] = 'multipart/form-data'
    form_data =
        {'login_id' => ENV['USER_NAME'], 'api_key' => ENV['API_KEY']}
    api_request.set_form(form_data, 'multipart/form-data')

    https = Net::HTTP.new(api_url.host, api_url.port)
    https.use_ssl = true
    response = https.request(api_request)
    alter_data(response)
  end

  def create_quote(auth_token, query_params = nil)
    api_url = ''
    base_url = URI(ENV['GET_QUOTE'])
    if query_params.nil?
      api_url = base_url
    else
      query_params = "?buy_currency=#{query_params[0]}&sell_currency=#{query_params[1]}&fixed_side=#{query_params[2]}&amount=#{query_params[3]}"
      api_url = URI(base_url + query_params)
    end
    https = Net::HTTP.new(api_url.host, api_url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(api_url)

    request['X-Auth-Token'] = auth_token
    response = https.request(request)
    response.read_body
  end

  def response_via_token(api_url, api_request, auth_token)
    api_request['X-Auth-Token'] = auth_token
    https = Net::HTTP.new(api_url.host, api_url.port)
    https.use_ssl = true
    response = https.request(api_request)
    response.read_body
  end

  def end_session(auth_token)
    LOG.info('Ending the session')
    api_url = URI(ENV['CLOSE_SESSION'])
    api_request = connect_to_url(api_url)
    response_via_token(api_url, api_request, auth_token)
  end

  def connect_to_url(url)
    Net::HTTP::Post.new(url)
  end

  def alter_data(response)
    token = response.read_body
    removed_auth_token = token.gsub!(/#{Regexp.escape('auth_token')}/, '')
    removed_auth_token.gsub!(/[^0-9A-Za-z]/, '')
  end
end
