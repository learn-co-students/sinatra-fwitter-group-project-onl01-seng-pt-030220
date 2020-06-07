class UsersController < ApplicationController

get "/" do
  erb :index
end

get "/signup"  do
   if !!session[:user_id]
      redirect to "/tweets"
   else
    erb :'users/signup'
  end
end

post "/signup"  do
   if params[:username]== "" || params[:password] == "" || params[:email] == ""
     redirect '/signup'
   end
     @user=User.new(username:params[:username],email:params[:email],password:params[:password])
     @user.save
     session[:user_id]=@user.id
     redirect '/tweets'
end

get "/login" do
  if  !!session[:user_id]
       redirect "/tweets"
  end
   erb :"users/login"
end

post "/login" do

   user = User.find_by(username: params[:username])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect  '/tweets'
  else
    redirect to "/login"
  end
end


get '/logout' do
  if !!session[:user_id]
     session.clear
     redirect to "/login"
   else
    redirect "/"
  end

end

get '/users/:slug' do
  #  @user = User.all.select{ |user| user.slug == params["slug"]}.first
  @user = User.find_by_slug(params[:slug])
  erb :'users/show'
end

end
