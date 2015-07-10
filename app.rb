ENV['RACK_ENV'] ||= 'development'  

require 'sinatra'
require 'bundler'
require 'data_mapper'

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
  not_found do
    halt 404, 'Page not found.'
  end

  get '/' do
    @title = 'Home'
    erb :home
  end
  
  get '/login' do
    erb :login
  end

  get '/new_post' do
    erb :new_post
  end

  get '/:id' do
    erb :single_post
  end

  get '/:id/edit' do 
    erb :edit_post
  end

  get '/:id/delete' do
    erb :edit_post
  end
end
