class UsersController < ApplicationController

    get '/signup' do 
        if Helpers.is_logged_in?(session)
          redirect to '/tweets'
        else 
          erb :'/users/create_user'
        end
    end 
    
    post '/signup' do
        if !params[:username].empty? && !params[:email].empty? && !params[:password].empty? 
          user = User.create(params)
          session[:user_id] = user.id 
        else
          redirect '/signup'
        end
    
        redirect to '/tweets'
    end

    get '/login' do 
        if Helpers.is_logged_in?(session)
            redirect '/tweets'
        else
            erb :'/users/login'
        end
    end 

    post '/login' do 
        @user = User.find_by(:username => params[:username])

        if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id
            redirect to '/tweets'
        else
            redirect to '/login'
		end
    end 

    get '/logout' do
        if Helpers.is_logged_in?(session)
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
