require 'rubygems'
require 'grape'
require 'json'
#TODO require 'omniauth-att'

require 'slim'

class App < Grape::API

#  configure do
#    set :sessions, true
#    set :inline_templates, true
#  end

#  default_format :txt
  content_type :html, 'text/html; charset=utf-8'

  helpers do
    def render(temp, &block )
      Slim::Template.new("./views/#{temp}.slim").render(self, &block)
    end
  end

  get '/' do
    render :index
  end

  get '/auth/:provider/callback' do
    render (:content, {"<h1>#{params[:provider]}</h1><pre>#{JSON.pretty_generate(request.env['omniauth.auth'])}</pre>"})
  end

  get '/auth/failure' do
    render (:error, {"<h1>Authentication Failed:</h1><h3>message:<h3> <pre>#{params}</pre>"})
  end

  get '/auth/:provider/deauthorized' do
    render (:logout, {"#{params[:provider]} has deauthorized this app."})
  end

  get '/protected' do
    throw(:halt, [401, "Not authorized\n"]) unless session[:authenticated]
    render (:protected, {"<pre>#{request.env['omniauth.auth'].to_json}</pre><hr><a href='/logout'>Logout</a>"})
  end

  get '/logout' do
    session[:authenticated] = false
    redirect '/'
  end

end



