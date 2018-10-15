require './config/environment'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

    configure do
      set :public_folder, 'public'
      set :views, 'app/views'
      enable :sessions
      set :session_secret, 'super secret'
    end

    get '/' do
      erb :index
    end

    helpers do
      def logged_in?
        !!session[:username]
      end



      def current_user
        @current_user ||= Chef.find_by(username: session[:username])
      end
    end

end
