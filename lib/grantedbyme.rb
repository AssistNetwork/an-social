##
# GrantedByMe Ruby SDK
# author: Andras Csizmadia <andras@grantedby.me>
#

require 'net/https'

class GrantedByMe

  VERSION = '1.0.9'
  BRANCH = 'master'
  HOST = 'https://api.grantedby.me/api/'

  ##
  # Constructor
  #
  def initialize(private_key, server_key)
    @crypto = Crypto.new
    @server_key = server_key
    @private_key = private_key
    @public_key = get_public_key
    @api_url = HOST
    if server_key
      @public_hash = Crypto.digest(server_key)
    end
  end

  ########################################
  # Getters / Setters
  ########################################

  ##
  # Returns the Service RSA public key in serialized PEM string format
  #
  def get_private_key
    return @private_key
  end

  ##
  # Returns the Service RSA public key in serialized PEM string format
  #
  def get_public_key
    private_rsa = OpenSSL::PKey::RSA.new @private_key
    return private_rsa.public_key.to_pem
  end

  ##
  # Returns the Server RSA public key in serialized PEM string format
  #
  def get_server_key
    return @server_key
  end

  ########################################
  # API
  ########################################

  ##
  # TBD
  #
  def activate_handshake(public_key)
    params = {}
    params['function'] = 'activate_handshake'
    params['public_key'] = public_key
    params['timestamp'] = Time.now.to_i
    uri = URI(@api_url)

    Net::HTTP.start(uri.host, uri.port,:use_ssl => uri.scheme == 'https') do |http|
      request = Net::HTTP::Post.new uri, initheader = {'Content-Type' => 'application/json'}
      request.body = params.to_json
      @response = http.request(request)
    end
    return JSON.parse(@response.body)
    rescue => e
      puts "failed: #{e}"
      return nil
  end

  ##
  # TBD
  #
  def activate_service(service_key)
    if @private_key == nil
      key = OpenSSL::PKey::RSA.new 2048
      @private_key = key.to_pem
    end
    if @server_key == nil
      handshake = activate_handshake(@public_key)
      if handshake && handshake['success'] && handshake['public_key']
        @server_key = handshake['public_key']
        @public_hash = Crypto.digest(@server_key)
      else
        raise "Handshake failed"
      end
    end
    params = get_params('activate_service')
    params['grantor'] = Base64.strict_encode64(OpenSSL::Random.random_bytes(128))
    params['service_key'] = service_key
    post(params)
  end

  ##
  # TBD
  #
  def deactivate_service
    params = get_params('deactivate_service')
    post(params)
  end

  ##
  # TBD
  #
  def get_account_token
    params = get_params('get_session_token')
    params['token_type'] = 1
    post(params)
  end

  ##
  # TBD
  #
  def get_account_state(token)
    params = get_params('get_session_state')
    params['token'] = token
    post(params)
  end

  ##
  # TBD
  #
  def link_account(token, grantor)
    params = get_params('link_account')
    params['token'] = token
    params['grantor'] = grantor
    post(params)
  end

  ##
  # TBD
  #
  def unlink_account(grantor)
    params = get_params('unlink_account')
    params['grantor'] = Crypto.digest(grantor)
    post(params)
  end

  ##
  # TBD
  #
  def get_session_token
    params = get_params('get_session_token')
    params['token_type'] = 2
    post(params)
  end

  ##
  # TBD
  #
  def get_session_state(token)
    params = get_params('get_session_state')
    params['token'] = token
    post(params)
  end

  ########################################
  # HELPERS
  ########################################

  ##
  # Assembles default POST request parameters
  #
  def get_params(function)
    params = {function: function}
    params['timestamp'] = Time.now.to_i
    params['http_user_agent'] = 'GrantedByMe/0.0.1-local (Ruby)'
    params['remote_addr'] = '127.0.0.1'
    # puts params
    params
  end

  ##
  # Sends a POST JSON request
  #
  def post(params)
    uri = URI(@api_url)
    Net::HTTP.start(uri.host, uri.port,:use_ssl => uri.scheme == 'https') do |http|
      request = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' => 'application/json', 'User-Agent' => 'GrantedByMe/0.0.1-local (Ruby)'})
      encrypted_params = @crypto.encrypt(params, @private_key, @server_key)
      encrypted_params['public_hash'] = @public_hash
      request.body = encrypted_params.to_json
      @response = http.request(request)
    end
    crypted_result = JSON.parse(@response.body)
    result = @crypto.decrypt(crypted_result, @private_key, @server_key)
    return result
    rescue => e
      puts "failed: #{e}"
      return '{"success": false}'
  end

end

#require 'date'
require 'json'
#require 'net/http'
require 'grantedbyme/crypto'
require 'openssl'
#require 'base64'