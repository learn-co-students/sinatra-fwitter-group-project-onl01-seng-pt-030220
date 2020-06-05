class TweetsController < ApplicationController

get "/tweets" do
  if  !session[:user_id]
       redirect "/login"
  end
    erb :'/tweets/index'
end

end
