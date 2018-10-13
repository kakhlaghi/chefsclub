class Chefscontroller < ApplicationController

  get '/chefs/:slug' do
    @chef = Chef.find_by_slug(params[:slug])
    erb :'/chefs/show'
  end

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect to '/dishes'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
     redirect to '/signup'
   else
     @chef = Chef.new(:username => params[:username], :email => params[:email], :password => params[:password])
     @chef.save
     session[:chef_id] = @chef.id
     redirect to '/dishes'
   end
  end

  get '/login' do
      if !logged_in?
        erb :'chef/login'
      else
        redirect to '/dishes'
      end
    end

    post '/login' do
      chef = Chef.find_by(:username => params[:username])
      if chef && chef.authenticate(params[:password])
        session[:chef_id] = chef.id
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
