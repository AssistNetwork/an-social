##
# GrantedByMe Ruby SDK
# author: Andras Csizmadia <andras@grantedby.me>
#

class Crypto

  ##
  # Constructor
  #
  def initialize()
    # puts decrypt(encrypt('test'))
    # puts @aes.encrypt('test')
    # puts @rsa.decrypt(@rsa.encrypt('Hello World'))
  end

  ########################################
  # API
  ########################################

  ##
  # TBD
  #
  def encrypt(data, private_key, public_key)
    aes = AES.new()
    rsa = RSA.new(private_key, public_key)
    json = data.to_json
    aes_result = aes.encrypt(json)
    message = Base64.strict_encode64(aes_result[0])
    aes_key = Base64.strict_encode64(aes_result[1])
    aes_iv = Base64.strict_encode64(aes_result[2])
    aes_signature = Base64.strict_encode64(aes_result[3])
    rsa_data = {cipher_key: aes_key, cipher_iv: aes_iv, signature: aes_signature}.to_json
    rsa_result = rsa.encrypt(rsa_data)
    rsa_signature = rsa.sign(rsa_data)
    result = {}
    result['payload'] = Base64.strict_encode64(rsa_result)
    result['signature'] = Base64.strict_encode64(rsa_signature)
    result['message'] = message
    # puts result
    return result
  end

  ##
  # TBD
  #
  def decrypt(data, private_key, public_key)
    aes = AES.new()
    rsa = RSA.new(private_key, public_key)
    payload = Base64.strict_decode64(data['payload'])
    signature = Base64.strict_decode64(data['signature'])
    cipher_data = rsa.decrypt(payload)
    cipher_json = JSON.parse(cipher_data)
    if (!rsa.verify(signature, cipher_data))
      raise 'Invalid RSA signature'
    end
    cipher_key = Base64.strict_decode64(cipher_json['cipher_key'])
    cipher_iv = Base64.strict_decode64(cipher_json['cipher_iv'])
    cipher_signature = Base64.strict_decode64(cipher_json['signature'])
    message = Base64.strict_decode64(data['message'])
    result = aes.decrypt(message, cipher_key, cipher_iv)
    if !aes.verify(result, cipher_key, cipher_signature)
      raise 'Invalid HMAC signature'
    end
    # puts result
    return JSON.parse(result)
  end

  ########################################
  # STATIC METHODS
  ########################################

  ##
  # TBD
  #
  def self.digest(input_string)
    normalized_string = input_string.encode(input_string.encoding, :universal_newline => true)
    return Digest::SHA2.new(512).hexdigest(normalized_string)
  end

end

require 'grantedbyme/crypto/aes'
require 'grantedbyme/crypto/rsa'
require 'json'
require 'base64'