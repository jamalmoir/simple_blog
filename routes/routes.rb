module Sinatra
  module SimpleBlog
    module Routing
    
      def self.registered(app)
        app.not_found do
         halt 404, 'Page not found.'
        end

        app.get '/' do
         @title = 'Home'
         erb :home
        end

        app.get '/login' do
         @title = 'Login'
         erb :login
        end

        app.get '/new_post' do
         erb :new_post
        end

        app.get '/:id' do
         erb :single_post
        end

        app.get '/:id/edit' do 
         erb :edit_post
        end

        app.get '/:id/delete' do
         erb :edit_post
        end
      end

    end
  end
end
