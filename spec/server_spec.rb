require_relative '../app.rb'
require 'rspec'
require 'rack/test'

set :environment, :test

describe 'Server Service' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

end
