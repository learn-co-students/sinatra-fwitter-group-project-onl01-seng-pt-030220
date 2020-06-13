require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret, "fwitter_secret"
  end

  get "/" do
    erb :home
  end

  get "/signup" do
    if logged_in?  
      redirect '/tweets'
    else
      erb :'/users/signup'
    end
  end

  post "/signup" do
    #binding.pry
    
    if !params[:email].empty? && !params[:username].empty? && !params[:password].empty?
      #binding.pry
      user = User.new(:email=> params[:email], :password=> params[:password], :username=> params[:username])
      user.save
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get "/login" do
    if logged_in?  
      redirect '/tweets'
    else
    erb :'/users/login'
    end
  end

  post "/login" do
    user = User.find_by(:username=>params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end


  # get "/logout" do
    
  #   if logged_in?
  #     erb :'/users/logout'
  #   else
  #     redirect "/"
  #   end
  # end

  # get "/logout" do 
  #   #binding.pry
  #   if params[:logout]
  #     session.destroy
  #     redirect "/login"
  #   else
  #     redirect "/tweets"
  #   end
  # end
  

  helpers do
    def logged_in?
     #binding.pry
      !!session[:user_id]
    end

    def current_user
        User.find(session[:user_id])
    end
  end
end
