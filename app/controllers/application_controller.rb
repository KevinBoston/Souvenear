require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    enable :logging
    set :session_secret, ENV['SESSION_SECRET']
  end

  get '/' do
    erb :index
  end
  get '/account' do 
    redirect to :'users/account'
  end


  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
    
    def is_admin?
      !!current_user.admin
    end



  end
end