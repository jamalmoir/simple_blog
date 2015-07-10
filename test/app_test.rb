ENV['RACK_ENV'] = 'test'

require_relative '../app'
require 'test/unit'
require 'rack/test'

class HomepageTest < Test::Unit::TestCase
  include Rack::Test::Methods
  def app() SimpleBlog  end

  def test_homepage
    get '/'
    assert last_response.ok?
  end
end
