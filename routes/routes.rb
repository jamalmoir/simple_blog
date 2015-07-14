module Sinatra
  module SimpleBlog
    module Routing

      def self.registered(app)
        app.not_found do
          halt 404, 'Page not found.'
        end

        app.get '/' do

          redirect '/login' unless login?

          @title = 'Home'
          @posts = Post.all :order => :id.desc

          unless session[:flash].nil?
            @flash = session[:flash]
            session[:flash] = nil
          end

          erb :home
        end

        app.get '/login' do
          redirect '/' if login?

          @title = 'Login'

          unless session[:flash].nil?
            @flash = session[:flash]
            session[:flash] = nil
          end

          erb :login
        end

        app.post '/login' do
          user = User.first(conditions: ["lower(username) = ? ",
                                                   params['username'].downcase])

          if params[:username].empty? || params[:password].empty?
            session[:flash] = 'Please provide a username and password'
            redirect '/login'
          elsif user == nil
            session[:flash] = 'Username or password is incorrect.'
            redirect '/login'
          elsif user.id == nil
            session[:flash] = 'Invalid login.'
            redirect '/login'
          end

          password = user.password

          if encrypt_sha2(params[:password]) == password
            session[:username] = user.username
            session[:id] = user.id
          end

          redirect '/'
        end

        app.get '/register' do
          redirect '/' if login?

          @title = 'Register'

          unless session[:flash].nil?
            @flash = session[:flash]
            session[:flash] = nil
          end

          erb :register
        end

        app.post '/register' do

          unless params[:password].empty?
            encrypted_password = encrypt_sha2 params[:password]
          else
            encrypted_password = ''
          end

          user = User.new(:username => params[:username],
                     :password => encrypted_password,
                     :email => params[:email],
                     :created_at => Time.now,
                     :updated_at => Time.now)

          if user.save
            redirect '/login'
          else
            session[:flash] = user.errors.full_messages.first
            redirect '/register'
          end

        end

        app.get '/new-post' do
          @title = 'New Post'

          redirect '/login' unless login?
          redirect '/' unless session[:id] = 1

          unless session[:flash].nil?
            @flash = session[:flash]
            session[:flash] = nil
          end

          erb :new_post
        end

        app.post '/new-post' do
          post = Post.new(:title => params[:title],
                          :content => params[:content],
                          :user_id => session[:id],
                          :created_at => Time.now,
                          :updated_at => Time.now)

          if post.save
            redirect '/'
          else
            session[:flash] = post.errors.full_messages.first
            redirect '/new-post'
          end

        end

        app.get 'post/:id' do
          erb :single_post
        end

        app.get 'post/:id/edit' do
          erb :edit_post
        end

        app.get 'post/:id/delete' do
         erb :edit_post
        end
      end

    end
  end
end
