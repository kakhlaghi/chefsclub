require 'pry'
class DishesController < ApplicationController

  get '/dishes' do
    #binding.pry
      if logged_in?
        #binding.pry
      #if !session[:email].empty?
        @dishes = Dish.all
        erb :'/dishes/dishes'
      else
        redirect to '/login'
      end
    end

    get '/dishes/new' do
      @errors = session[:errors]
      session[:errors] = nil
      if logged_in?
        erb :'dishes/create_dish'
      else
        redirect to '/login'
      end
    end

    post '/dishes' do
      if logged_in?
        if params[:name] == ""
          error = "The name is blank"
          session[:errors] = error
          redirect to "/dishes/new"
        else
          @dish = current_user.dishes.create(:name => params[:name], :chef_id => current_user.id)
          if @dish.save
            redirect to "/dishes/#{@dish.id}"
          else
            error = @dish.errors
            session[:errors] = error
            redirect to "/dishes/new"
          end
        end
      else
        redirect to '/login'
      end
    end

    get '/dishes/:id' do
      if logged_in?
        @dish = Dish.find_by_id(params[:id])
        erb :'dishes/show_dish'
      else
        redirect to '/login'
      end
    end

    get '/dishes/:id/edit' do
      if logged_in?
        @dish = Dish.find_by_id(params[:id])
        if @dish && @dish.chef == current_user
          erb :'dishes/edit_dish'
        else
          redirect to '/dishes'
        end
      else
        redirect to '/login'
      end
    end

    patch '/dishes/:id' do
      if logged_in?
        if params[:content] == ""
          redirect to "/dishes/#{params[:id]}/edit"
        else
          @dish = Dish.find_by_id(params[:id])
          if @dish && @dish.chef = current_user
            if @dish.update(name: params[:name])
              redirect to "/dishes/#{@dish.id}"
            else
              redirect to "/dishes/#{@dish.id}/edit"
            end
          else
            redirect to '/dishes'
          end
        end
      else
        redirect to '/login'
      end
    end

    delete '/dishes/:id/delete' do
      if logged_in?
        @dish = Dish.find_by_id(params[:id])
        if @dish && @dish.chef == current_user
          @dish.delete
        end
        redirect to '/dishes'
      else
        redirect to '/login'
      end
    end
  end
