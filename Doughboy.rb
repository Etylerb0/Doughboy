require 'sinatra'
require 'unirest'

get '/' do
	@title = 'Photos'
	@photos = recent_photos
	erb :all_photos
end

def recent_photos (hashtag = "tbt", resolution = "thumbnail")
		@photos = []
		instagram_response = "https://api.instagram.com/v1/tags/#{hashtag}/media/recent?client_id=c385f242ca38471a8d6357849ab3d356"
		response = Unirest.get(instagram_response)
		photos_array = response.body["data"]

		photos_array.each do |photo|
			image = photo["images"][resolution]["url"]
			@photos << image
		end

		@photos
	end

get '/:resolution/:hashtag' do 
	@title = 'Photos'
	@photos = recent_photos(params[:hashtag],params[:resolution])
	erb :all_photos
end


