require './config/environment'

class ApplicationController < Sinatra::Base

    configure do
      set :public_folder, 'public'
      set :views, 'app/views'
      enable :sessions
    end

    get '/' do
      index.erb
    end

    helpers do
      def logged_in?
        !!current_user
      end

      def current_user
         @current_user ||= Chef.find_by(id: session[:chef_id]) if session[:chef_id]
      end
    end

end
