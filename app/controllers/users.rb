get '/users/new' do
  @user = User.new
  erb :"users/new"
end

post '/users' do
  @user = User.new(params[:user])

  if @user.save
    session[:user_id] = @user.id
    redirect '/'
  else
    @errors = @user.errors.full_messages
    erb :"users/new"
  end
end

get '/users/:id' do
  authenticate!
  @user = User.find_by(id: params[:id])
  erb :"users/show"
end

get '/users/:id/locations' do
  authenticate!
  @user = User.find_by(id: params[:id])
  ep @user_locations = @user.locations
  erb :"/users/show"
end

get '/users/:id/locations/new' do
  authenticate!
  erb :"/locations/new"
end

post '/users/:id/locations' do
  authenticate!
  @found_location = Location.find_by(city: params[:location][:city], region: params[:location][:region], country: params[:location][:country])
  @new_location = Location.new(params[:location])
  if @found_location
    current_user.locations << @found_location
    @weather_info = @found_location.weather
    redirect "/locations/#{@found_location.id}"
  else
    if @new_location.save
      current_user.locations << @new_location
      @weather_info = @new_location.weather
      redirect "/locations/#{@new_location.id}"
    else
      @errors = @new_location.errors.full_messages
      redirect '/locations'
    end
  end
end

delete '/users/:id/locations/:location_id' do
  authenticate!
  @user_location = UserLocation.find_by(user_id: current_user.id, location_id: params[:location_id])
  authorize!(@user_location.user)
  @user_location.destroy
  redirect "/users/#{current_user.id}/locations"
end

