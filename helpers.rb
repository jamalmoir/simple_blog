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

      def get_user_from_id(id)
        user = User.get(id)
        user
      end

      def get_name_from_id(id)
        name = get_user_from_id(id).username
        name
      end

      def error_list(errors)
        #{:email => [{:presence=>"..."}]}
        @errors = []
        errors.each do |key, value|
          @errors.push value
        end

        @errors
      end
    end
  end
end
