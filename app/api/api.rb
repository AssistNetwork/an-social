require 'rubygems'
require 'grape'
require 'json'
#TODO require 'omniauth-att'

require 'slim'

class Api < Grape::API

#  default_format :txt
  content_type :html, 'text/html; charset=utf-8'

  helpers do
    def render(temp, &block )
      unless block.nil?
        Slim::Template.new("./views/#{temp}.slim").render(self, block.call)
      else
        Slim::Template.new("./views/#{temp}.slim").render(self)
      end

    end
  end

  get '/' do
    render :index
  end

 get '/auth/:provider/callback' do
    request.env['omniauth.auth'].to_hash.inspect rescue "No Data"
    render :callback
    #render :callback unless request.env['omniauth.auth'].nil?
    # TODO GRANTEDBY.ME!!!
    p request.env['omniauth.auth'].to_yaml.to_s
  end

  get '/auth/failure' do
 #   render (:error, {"<h1>Authentication Failed:</h1><h3>message:<h3> <pre>#{params}</pre>"})
    render :error
  end

  get '/auth/:provider/deauthorized' do
 #   render (:logout, {"#{params[:provider]} has deauthorized this app."})
  end

  get '/protected' do
    throw(:halt, [401, "Not authorized\n"]) unless session[:authenticated]
 #   render (:protected, {"<pre>#{request.env['omniauth.auth'].to_json}</pre><hr><a href='/logout'>Logout</a>"})
  end

  get '/logout' do
    session[:authenticated] = false
    redirect '/'
  end

end



