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
          redirect '/' if login?

          @title = 'Login'
          erb :login
        end

        app.post '/login' do
          user = User.first(conditions: ["lower(username) = ? ",
                                                   params['username'].downcase])

          if params[:username].empty? || params[:password].empty?
            #message
            redirect '/login'
          elsif user == nil
            #flash[:error] = 'Username or password is incorrect.'
            redirect '/login'
          elsif user.id == nil
            #flash[:error] = 'Invalid login.'
            redirect '/login'
          end

          password = user.password

          if encrypt_sha2(params[:password]) == password
            session[:username] = user.username
          end

          redirect '/'
        end

        app.get '/register' do
          redirect '/' if login?

          @title = 'register'
          erb :register
        end

        app.post '/register' do
          #TODO: Validate
          user = User.create(:username => params[:username],
                     :password => encrypt_sha2(params[:password]),
                     :email => params[:email],
                     :created_at => Time.now,
                     :updated_at => Time.now)
          p user
          redirect '/register' if user.id.nil?
          redirect '/login'
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
