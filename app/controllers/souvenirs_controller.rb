class SouvenirsController < ApplicationController
    get '/souvenirs' do 
        if logged_in?
            @souvenirs = current_user.souvenirs
            erb :'/souvenirs/souvenirs'
        else
            redirect to '/login'
        end
    end

    get '/souvenirs/new' do 
        if logged_in?
            @user = current_user
            erb :'/souvenirs/create_souvenir'
        else
            redirect to '/login'
        end
    end

    post '/souvenirs' do 
        if logged_in? 
            if params[:souvenirname] == ""
                redirect to '/souvenirs/new'
            else
                @trip = Trip.find_by_id(params[:souvenir][:trip_id])
                @souvenir = @trip.souvenirs.build(souvenirname: params[:souvenirname])
                if @souvenir.save
                    redirect to "/souvenirs/#{@souvenir.id}"
                else
                    redirect to '/souvenirs/new'
                end
            end
        else
            redirect to '/login'
        end
    end

    get '/souvenirs/:id' do
        if logged_in?
            @souvenir = Souvenir.find_by_id(params[:id])
            @trip = Trip.find_by_id(@souvenir.trip_id)
            erb :'/souvenirs/view_souvenir'
        else
            redirect to '/login'
        end
    end

    get '/souvenirs/:id/edit' do 
        if logged_in?
            
            @souvenir = Souvenir.find_by_id(params[:id])
            if @souvenir && @souvenir.trip.user == current_user
                erb :'souvenirs/edit_souvenir'
            else 
                redirect to '/users/account'
            end
        else
            redirect to '/login'
        end
    end

    patch '/souvenirs/:id' do 
        if logged_in?
            if params[:souvenirname] == ""
                redirect to "/souvenirs/#{params[:id]}/edit"
            else
                @souvenir = Souvenir.find_by_id(params[:id])
                if @souvenir && @souvenir.trip.user == current_user
                    if @souvenir.update(souvenirname: params[:souvenirname])
                        redirect to "/souvenirs/#{@souvenir.id}"
                    else 
                        redirect to "/souvenirs/#{@souvenir.id}/edit"
                    end
                else 
                    redirect to '/users/account'
                end
            end
        else
            redirect to '/login'
        end 
    end

    delete '/souvenirs/:id/delete' do 
        if logged_in?
            @souvenir = Souvenir.find_by_id(params[:id])
            if @souvenir && @souvenir.trip.user == current_user
                @souvenir.delete
            end
            redirect to '/users/account'
        else 
            redirect to '/login'
        end
    end
end