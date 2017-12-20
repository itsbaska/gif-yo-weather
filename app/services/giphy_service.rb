class GiphyServices
  def self.get_gif(weather)
    input_weather = weather.gsub(/\s/, '+')

    url = "http://api.giphy.com/v1/gifs/search?q=#{input_weather}&api_key=#{ENV['GIF_SECRET']}&limit=5"
    resp = Net::HTTP.get_response(URI.parse(url))
    buffer = resp.body
    result = JSON.parse(buffer)
    result["data"].sample["id"]
  end
end
