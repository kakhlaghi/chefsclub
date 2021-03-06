require 'pry'
class ChefsController < ApplicationController

  get '/chefs/:slug' do
    @chef = Chef.find_by_slug(params[:slug])
    @dishes = Dish.all
    erb :'/dishes/dishes'
  end

  get '/signup' do
    if !logged_in?
      erb :'chefs/create_chef'
    else
      redirect to '/dishes'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == "" || Chef.find_by(:username => params[:username])
     redirect to '/signup'
   else
     @chef = Chef.new(params[:chef])
     @chef.username = params[:username]
     @chef.email = params[:email]
     @chef.password = params[:password]
     @chef.save
     session[:username] = @chef.username #change
     redirect to '/dishes'
   end
  end

    get '/login' do
      if !logged_in?
        erb :'chefs/login'
      else
        redirect to '/dishes'
      end
    end

    post '/login' do
      @chef = Chef.find_by(:username => params[:username])
      if @chef && @chef.authenticate(params[:password])
        session[:username] = @chef.username
        redirect to "/dishes"
      else
        redirect to '/signup'
      end
    end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end
