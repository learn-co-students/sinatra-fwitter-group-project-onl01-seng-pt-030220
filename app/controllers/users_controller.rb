class UsersController < ApplicationController

    get '/signup' do
        erb :'/users/create_user'
    end

    post '/signup' do
        if !params[:username].empty? || !params[:email].empty? || !params[:password].empty?
          redirect to '/signup'
        else
          @user = User.create(params)
          @user.save
          session[:user_id] = @user.id
          redirect to '/tweets'
        end
      end
     
end
