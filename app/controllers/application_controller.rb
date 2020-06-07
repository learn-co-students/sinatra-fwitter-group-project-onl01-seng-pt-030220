require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, 'secret'
  end

  get '/' do
    erb :index
  end 

  get "/home" do
    if !session[:user_id]
      redirect "/"
    else
      redirect "/tweets"
    end
  end

end
