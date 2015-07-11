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

        app.get '/register' do
          @title = 'register'
          erb :register
        end

        app.post '/register' do
          user = User.new
          user.username = params[:username]
          user.password = encrypt_sha2 params[:password]
          user.created_at = Time.now
          user.updated_at = Time.now
          user.save
          redirect '/'
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
