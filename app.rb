ENV['RACK_ENV'] ||= 'development'

require 'bundler'
require 'sinatra/base'
require 'data_mapper'

require_relative 'helpers'
require_relative 'routes/routes'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/simpleblog.db")

class User
  include DataMapper::Resource

  # attributes
  property :id,         Serial
  property :username,   String
  property :password,   String, :length => 64
  property :email,      String
  property :created_at, DateTime
  property :updated_at, DateTime

  # validation
  validates_presence_of :username,
    :message => 'Please provide a username.'
  validates_with_method :username,
    :method => :unique_username_ignore_case,
    :message => 'This username already exists.'
  validates_length_of :username, :min => 2, :max => 30,
    :message => 'Username must be between two and thirty characters.'
  validates_presence_of :password,
    :message => 'Please provide a password.'
  validates_presence_of :email,
    :message => 'Please provide an email.'
  validates_uniqueness_of :email,
    :message => 'This email address already exists.'
  validates_format_of :email, :as => :email_address,
    :message => 'Please enter a valid email address.'

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

  # validation
  validates_presence_of :title,
    :message => 'Please provide a title.'
  validates_presence_of :content,
    :message => 'Please provice content.'
  validates_presence_of :user_id,
    :message => 'Something went wrong: User ID not provided'
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
