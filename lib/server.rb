env = ENV["RACK_ENV"] || "development"
require "data_mapper"
require "sinatra"

DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")
require './lib/link.rb'
require './lib/tag.rb'
require './lib/user.rb'
DataMapper.finalize
DataMapper.auto_upgrade!
require './lib/helpers/application.rb'

enable :sessions
set :session_secret, 'super secret'

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

get '/tags/:text' do
	tag = Tag.first(:text => params[:text])
	@links = tag ? tag.links : []
	erb :index
end

get '/users/new' do
	erb :"users/new"
end

post '/users' do
  user = User.create(:email => params[:email], 
              :password => params[:password])
  session[:user_id] = user.id
  redirect to('/')
end