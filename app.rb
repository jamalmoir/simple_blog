ENV['RACK_ENV'] ||= 'development'

require 'bundler'
require 'sinatra/base'
require 'data_mapper'

require_relative 'helpers'
require_relative 'routes/routes'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/simpleblog.db")

class User
  include DataMapper::Resource

  property :id,         Serial
  property :username,   String,    :required => true,
    :message => { :presence => "Please provide a username." }
  property :password,   String,    :required => true, :length => 64,
    :message => { :presence => "Please provide a password." }
  property :email,      String,    :required => true, :unique => true,
    :format  => :email_address,
    :message => {
      :presence  => "Please provide an email address.",
      :is_unique => "Email already exists.",
      :format    => "Please enter a valid email address."
    }
  property :created_at, DateTime
  property :updated_at, DateTime

  validates_with_method :username, :method => :unique_username_ignore_case,
    :message => "This username already exists."
  validates_length_of :username, :min => 2, :max => 30,
    :message => "Username must be between two and thirty characters."

  def unique_username_ignore_case
    User.first(conditions: ["lower(username) = ?", self.username.downcase]).nil?
  end
end

class Post
  include DataMapper::Resource

  property :id,         Serial
  property :title,      String,  :required => true
  property :content,    Text,    :required => true
  property :user_id,    Integer, :required => true
  property :created_at, DateTime
  property :updated_at, DateTime
end

class Page
  include DataMapper::Resource

  property :id,         Serial
  property :title,      String,  :required => true
  property :content,    Text,    :required => true
  property :user_id,    Integer, :required => true
  property :created_at, DateTime
  property :updated_at, DateTime
end

DataMapper.finalize.auto_upgrade!


class SimpleBlog < Sinatra::Base

  enable :sessions

  helpers Sinatra::SimpleBlog::Helpers

  register Sinatra::SimpleBlog::Routing

end
