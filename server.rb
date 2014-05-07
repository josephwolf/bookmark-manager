env = ENV["RACK_ENV"] || "development"
require "data_mapper"
require "sinatra"
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")
require './lib/link.rb'
DataMapper.finalize
# DataMapper.auto_update!

configure :production do
  require 'newrelic_rpm'
end

get "/" do
	erb :index
end