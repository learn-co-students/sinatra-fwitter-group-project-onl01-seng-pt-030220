class TweetsController < ApplicationController

    get "/tweets" do
        if session[:user_id]   
            @user = User.find_by(id: session[:user_id])
            @users = User.all
            erb :"/tweets/index"
        else
            redirect "/login"
        end
    end

    get "/tweets/new" do
        if Helpers.is_logged_in?(session)
            @error = ""
            erb :"/tweets/new"
        else
            redirect "/login"
        end
    end

    post "/tweets" do
        if !params["content"].empty?
            tweet = Tweet.create(content: params[:content], user_id: session[:user_id])
            redirect "/tweets"
        else
            @error = "You must fill on the text box."
            redirect "/tweets/new"
        end
    end

    get "/tweets/:id" do
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find(params[:id])
            erb :"/tweets/show"
        else
            redirect "/login"
        end
    end

    get "/tweets/:id/edit" do
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find(params[:id])
            # binding.pry
            if Helpers.current_user(session).id == @tweet.user_id
                erb :"/tweets/edit"
            else
                redirect "/tweets"
            end
        else
            redirect "/login"
        end
    end

    post "/tweets/:id" do
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
        if Helpers.current_user(session).id == @tweet.user_id
            @tweet = Tweet.find(params[:id])
            @tweet.destroy
            redirect "/tweets"
        else
            redirect "/tweets"
        end
    end

end
