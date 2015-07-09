ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

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
