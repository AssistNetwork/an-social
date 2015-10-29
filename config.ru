$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rubygems'

require 'omniauth'
require 'omniauth-github'
require 'omniauth-facebook'
require 'omniauth-twitter'

use Rack::Session::Cookie, secret: 'huspvhsfdvdfvie324r2miw6y46etettooiorertrrehrye'

use OmniAuth::Builder do
  provider :github, 'b0bbb3badec971bdf6d6','78a00c0afda67a3892e4fd135ed3325492f97fdc'
  provider :facebook, '1516715661975491','a2ceff17b400bb24b8b9d3a12595c868'
  provider :twitter, 'JucYMj3W8m49UZ6TerlaqNiP2', 'F2YW82EEgKkeXg6OGJYe0JXDfZR4cgEopgl4ApW9VLfwHIm0Kz'
  #provider :att, 'client_id', 'client_secret', :callback_url => (ENV['BASE_DOMAIN']
end


require 'app'
run App

=begin
github
Client ID
    605c832bd4eb93eb3c2a
Client Secret
    5f160ead52af923368fafb2a063a1cfaaeed96b2

facebook
App ID
1516715661975491
App Secret
a2ceff17b400bb24b8b9d3a12595c868

twitter
 Consumer Key (API Key) JucYMj3W8m49UZ6TerlaqNiP2
Consumer Secret (API Secret) F2YW82EEgKkeXg6OGJYe0JXDfZR4cgEopgl4ApW9VLfwHIm0Kz

=end
