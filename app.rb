ENV['RACK_ENV'] ||= 'development'  

require 'sinatra'
require 'bundler'
require 'data_mapper'

require_relative 'helpers'
require_relative 'routes/routes'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/simpleblog.db")

class User
  include DataMapper::Resource
  property :id, Serial
  property :username, String, :required => true
  property :password, String, :required => true
  property :created_at, DateTime
  property :updated_at, DateTime
end

class Post
  include DataMapper::Resource
  property :id, Serial
  property :title, String, :required => true
  property :content, Text, :required => true
  property :user_id, Integer, :required => true
  property :created_at, DateTime
  property :updated_at, DateTime
end

class Page
  include DataMapper::Resource
  property :id, Serial
  property :title, String, :required => true
  property :content, Text, :required => true
  property :user_id, Integer, :required => true
  property :created_at, DateTime
  property :updated_at, DateTime
end

DataMapper.finalize.auto_upgrade!


class SimpleBlog < Sinatra::Base
  helpers Sinatra::SimpleBlog::Helpers

  register Sinatra::SimpleBlog::Routing  
end
