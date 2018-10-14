require './config/environment'

class ApplicationController < Sinatra::Base

    configure do
      set :public_folder, 'public'
      set :views, 'app/views'
      enable :sessions
    end

    get '/' do
      erb :index
    end

    helpers do
      def logged_in?
        !!session[:username]
      end

      def current_user
        Chef.find(session[:id])
      end
    end

end
