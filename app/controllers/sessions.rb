# render login page
get '/sessions/new' do
  erb :"sessions/new"
end

post '/sessions' do
  @user = User.find_by(username: params[:username])

  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect '/'
  else
    @errors = ["Either your username or password was wrong"]
    erb :"sessions/new"
  end
end

delete '/sessions' do
  session.delete(:user_id)
  redirect '/'
end

get '/not_authorized' do
  erb :not_authorized
end
