class TweetsController < ApplicationController

get "/tweets" do
  if  !session[:user_id]
       redirect "/login"
  end
    erb :'/tweets/index'
end

get '/tweets/new'  do
#  binding.pry
  if !!session[:user_id]
      erb :'tweets/new'
    else
    redirect '/login'
  end
end

post '/tweets'  do
  if params[:content] != ""
     #if !!session[:user_id]
        @tweet=Tweet.new(content:params[:content])
        @tweet.save
        user=Helpers.current_user(session)
        @tweet.user = user
        redirect '/tweets'
    # end
  else
      redirect "tweets/new"
  end
end


get "/tweets/:id/edit" do
  @tweet=Tweet.find_by_id(params[:id])
  #if !!session[:user_id]
     erb :"/tweets/edit"
  #end
end

patch "/tweets/:id" do
  binding.pry
  @tweet =Tweet.find_by_id(params[:id])
  @tweet.update(name:params[:content])
  redirect "/tweets/#{@tweet.id}"
end

get '/tweets/:id'  do
  if !!session[:user_id]
    @tweet=Tweet.find(params[:id])
     erb:'tweets/show'
   else
      redirect '/login'
   end
end


end
