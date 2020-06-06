class UsersController < ApplicationController

    get "/signup" do
        if !session[:user_id]
          @error = false
          erb :signup
        else
          redirect "/tweets"
        end
    end
    
    post "/signup" do
        if !params[:username].empty? && (!params[:email].empty? && params[:email].include?("@")) && !params[:password].empty?
            user = User.new(username: params[:username], email: params[:email], password: params[:password])
            if user.save
            session[:user_id] = user.id
            redirect "/tweets"
            else
            @error = true
            redirect "/signup"
            end
        else
            @error = true
            redirect "/signup"
        end
    end
    
    get "/login" do
        if session[:user_id]
          redirect "/tweets"
        else
          @error = true
          erb :login
        end
    end
    
    post "/login" do 
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect "/tweets"
        else
          redirect "/login"
        end
    end

    get "/logout" do
        if session[:user_id]
            session.clear
            redirect "/login"
        else
            redirect "/"
        end
    end

    get "/users/:id" do
      @user = User.find(params[:id])
      erb :"users/show"
    end
end
