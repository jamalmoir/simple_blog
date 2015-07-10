ENV['RACK_ENV'] = 'test'

require_relative '../app'
require 'test/unit'
require 'rack/test'

class HomepageTest < Test::Unit::TestCase
  include Rack::Test::Methods
  def app() SimpleBlog  end

  def test_get_home_page
    get '/'
    assert last_response.ok?
  end
end

class LoginTest < Test::Unit::TestCase
  include Rack::Test::Methods
  def app() SimpleBlog end

  def test_get_login_page
    get '/login'
    assert last_response.ok?
  end
end

class SetupTest < Test::Unit::TestCase
  include Rack::Test::Methods
  def app() SimpleBlog end

  def test_get_setup_page
    get '/setup'
    assert last_response.ok?
  end
end
