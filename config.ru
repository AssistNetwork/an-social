$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rubygems'

require 'omniauth'
require 'omniauth-github'
require 'omniauth-facebook'
require 'omniauth-twitter'

use Rack::Session::Cookie, secret: 'huspvhsfdvdfvie324r2miw6y46etettooiorertrrehrye'

use OmniAuth::Builder do
  provider :github, 'ece9da5a3cff23b3475f','eb81c6098ba5d08e3c2dbd263bf11de5f3382d55'
  provider :facebook, '290594154312564','a26bcf9d7e254db82566f31c9d72c94e'
  provider :twitter, 'cO23zABqRXQpkmAXa8MRw', 'TwtroETQ6sEDWW8HEgt0CUWxTavwFcMgAwqHdb0k1M'
  #provider :att, 'client_id', 'client_secret', :callback_url => (ENV['BASE_DOMAIN']
end


require 'app'
run App