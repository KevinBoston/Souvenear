class UsersController < ApplicationController
  get '/users/account' do 
    @user = current_user
    erb :'/users/account'
  end
  

  
  get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      erb :'users/account'
    end
  
    get '/signup' do
      if !logged_in?
        erb :'users/create_user', locals: {message: "Please sign up before you sign in"}
      else
        redirect to '/users/account'
      end
    end
  
    post '/signup' do
      if params[:username] == "" || params[:name] == "" || params[:password] == ""
        redirect to '/signup'
      else
        @user = User.new(:username => params[:username], :name => params[:name], :password => params[:password])
        @user.save
        session[:user_id] = @user.id
        redirect to '/users/account'
      end
    end
  
    get '/login' do
      if !logged_in?
        erb :'users/login'
      else
        redirect to '/users/account'
      end
    end
  
    post '/login' do
      user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect to "/users/account"
      else
        redirect to '/signup'
      end
    end
  
    get '/logout' do
      if logged_in?
        session.destroy
        redirect to '/'
      else
        redirect to '/'
      end
    end
    get '/make_admin' do 
      erb :'/users/make_admin'
    end

    post '/make_admin' do 
      if logged_in?
        @user = current_user
        @user.admin = true 
        @user.save
        redirect to '/users/account'
      else
        redirect to '/'
      end
    end

    post '/remove_admin' do 
      if logged_in?
        @user = current_user
        @user.admin = false 
        @user.save
        redirect to '/users/account'
      else
        redirect to '/'
      end
    end
  end