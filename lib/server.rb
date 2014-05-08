env = ENV["RACK_ENV"] || "development"
require "data_mapper"
require "sinatra"

DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")
require './lib/link.rb'
require './lib/tag.rb'
DataMapper.finalize
DataMapper.auto_upgrade!

configure :production do
  require 'newrelic_rpm'
end

get "/" do
	@links = Link.all
	erb :index
end


post '/links' do
	url = params["url"]
	title = params["title"]
	tags = params["tags"].split(" ").map{|tag| Tag.first_or_create(:text => tag)}
	Link.create(:url => url, :title => title, :tags => tags)
	redirect to('/')
end

