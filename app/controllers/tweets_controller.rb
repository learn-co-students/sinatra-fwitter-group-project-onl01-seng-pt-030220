class TweetsController < ApplicationController

    get '/tweets' do 
        if Helpers.is_logged_in?(session)
            @tweets = Tweet.all
            erb :'/tweets/tweets'
        else
            redirect '/login'
        end
    end 

    get '/tweets/new' do 
        if Helpers.is_logged_in?(session)
            @error = ""
            erb :"/tweets/new"
        else
            redirect "/login"
        end
    end 

    post '/tweets' do 
        if !params[:content].empty?
            tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
            redirect '/tweets'
        else 
            @error = "You must fill on the text box."
            redirect "/tweets/new"
        end
    end 

    get '/tweets/:id' do
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find_by_id(params[:id])
            erb :"/tweets/show_tweet"
        else 
            redirect '/login'
        end 
    end 

    get "/tweets/:id/edit" do
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find(params[:id])
            if Helpers.current_user(session).id == @tweet.user_id
                erb :"/tweets/edit_tweet"
            else
                redirect "/tweets"
            end
        else
            redirect "/login"
        end
    end

    patch "/tweets/:id" do
        if !params[:content].empty?
            @tweet = Tweet.find(params[:id])
            @tweet.content = params[:content]
            @tweet.save
            redirect "/tweets"
        else
            redirect "/tweets/#{params[:id]}/edit"
        end
    end

    delete "/tweets/:id" do
        @tweet = Tweet.find(params[:id])
        if Helpers.is_logged_in?(session)
            if Helpers.current_user(session).id == @tweet.user_id
                @tweet = Tweet.find(params[:id])
                @tweet.destroy
                redirect "/tweets"
            else
                redirect "/tweets"
            end 
        else 
            redirect "/login"
        end
    end
    
end
