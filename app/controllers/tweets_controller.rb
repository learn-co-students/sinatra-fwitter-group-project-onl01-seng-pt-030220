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
        user=Helpers.current_user(session)
        @tweet.user = user
        @tweet.save
     redirect '/tweets'
    # end
  else
      redirect "tweets/new"
  end
end


get "/tweets/:id/edit" do

    if  !Helpers.is_logged_in?(session)
        redirect "/login"
    end

    @tweet=Tweet.find_by_id(params[:id])
    user=Helpers.current_user(session)

    if @tweet.user_id != user.id
       redirect "/tweets"

     else
       erb :"/tweets/edit"
    end
end

patch '/tweets/:id' do
  @tweet =Tweet.find_by_id(params[:id])

if params[:content] == ""
     redirect "/tweets/#{@tweet.id}/edit"
end
@tweet.update(content:params[:content])
@tweet.save
redirect "/tweets/#{@tweet.id}"

end

get '/tweets/:id'  do
  binding.pry

  if !!session[:user_id]
     @tweet=Tweet.find_by_id(params[:id])
     erb:'tweets/show'
   else
      redirect '/login'
   end
end


delete '/tweets/:id'  do

      if  !Helpers.is_logged_in?(session)
        redirect '/login'
      end

      @tweet=Tweet.find_by_id(params[:id])
      user=Helpers.current_user(session)
      if @tweet.user_id != user.id
          redirect "/tweets"
      end
       @tweet.destroy
       redirect "/tweets"
end


end
