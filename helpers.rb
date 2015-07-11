require 'digest'

module Sinatra
  module SimpleBlog
    module Helpers

      def encrypt_sha2(text)
        Digest::SHA2.hexdigest text
      end

    end
  end
end
