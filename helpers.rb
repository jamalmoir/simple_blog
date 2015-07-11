require 'digest'

module Sinatra
  module SimpleBlog
    module Helpers

      def encrypt_sha2(text)
        Digest::SHA2.hexdigest text
      end

      def login?
        session[:username].nil? ? false : true
      end

      def require_login
        redirect'/login' unless login?
      end

      def username
        session[:username]
      end
    end
  end
end
