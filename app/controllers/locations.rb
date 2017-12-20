get '/locations' do
  @locations = Location.all
  erb :"/locations/index"
end

get '/locations/new' do
  authenticate!
  erb :"/locations/new"
end

get '/locations/:id' do
  authenticate!
  @location = Location.find(params[:id])
  @weather_info = @location.weather
  erb :"/locations/show"
end

