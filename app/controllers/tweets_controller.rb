class TweetsController < ApplicationController
    get "/tweets" do
        #binding.pry
       
        if logged_in?
            @tweets = Tweet.all
            @user = current_user
            erb :'/tweets/index'
        else 
            redirect "/login"
        end
    end

    get "/tweets/new" do
        if logged_in?
            erb :'/tweets/new'
        else
            redirect '/login'
        end
    end

    post "/tweets" do
        #binding.pry
        if !params[:content].empty?
            Tweet.create(content: params[:content], user_id: current_user.id)
        else
            redirect "/tweets/new"
        end  
    end

    get "/tweets/:id" do
       # binding.pry
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :'tweets/show'
        else
            redirect '/login'
        end
    end

    delete "/tweets/:id/delete" do
        tweet = Tweet.find(params[:id]) 
        if logged_in? && current_user.tweets.include?(tweet)
            tweet.delete
        else
            redirect '/login'
        end
    end

    get "/tweets/:id/:edit" do
        @tweet = Tweet.find(params[:id]) 
        if logged_in? && current_user.tweets.include?(@tweet)
            erb :"/tweets/edit"
        else
            redirect '/login'
        end

    end

    patch "/tweets/:id" do
       # binding.pry
        tweet = Tweet.find(params[:id]) 
        if logged_in? && current_user.tweets.include?(tweet) && !params[:content].empty?
            tweet.content = params[:content]
            tweet.save
            redirect "/tweets/#{tweet.id}"
        else
            redirect '/login'
        end
    end

end
