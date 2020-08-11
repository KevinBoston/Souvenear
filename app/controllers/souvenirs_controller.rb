class SouvenirsController < ApplicationController
    get '/souvenirs' do 
        if logged_in?
            @souvenirs = Souvenir.all.map {|souv|current_user.trips.include?(souv.trip_id)}
            erb :'souvenirs/souvenirs'
        else
            redirect to '/login'
        end
    end

    get '/souvenirs/new' do 
        if logged_in?
            erb :'souvenirs/create_souvenir'
        else
            redirect to '/login'
        end
    end

    post '/souvenirs' do 
        if logged_in? 
            if params[:souvenir_name] == ""
                redirect to '/souvenir/new'
            else
                @souvenir = current_user.trips.souvenirs.create(params[:souvenir_name])
                if @souvenir.save
                    redirect to '/souvenirs/#{@souvenir.id}'
                else
                    redirect to '/souvenirs/new'
                end
            end
        else
            redirect to '/login'
        end
    end

#    get '/souvenirs/:id'
#        if logged_in?
#            @souvenir = Souvenir.find_by_id(params[:id])
#            erb :'souvenirs/view_trip'
#        else
#            redirect to '/login'
#        end
#    end

    get '/souvenirs/:id/edit' do 
        if logged_in?
            @souvenir = Souvenir.find_by_id(params[:id])
            if @souvenir && @souvenir.trip.user == current_user
                erb :'souvenirs/edit_souvenir'
            else 
                redirect to '/souvenirs'
            end
        else
            redirect to '/login'
        end
    end

    patch '/tweets/:id' do 
        if logged_in?
            if params[:souvenir_name] == ""
                redirect to "/souvenirs/#{params[:id]}/edit"
            else
                @souvenir = Souvenir.find_by_id(params[:id])
                if @souvenir && @souvenir.trip.user == current_user
                    if @souvenir.update(souvenir_name: params[:souvenir_name])
                        redirect to "/souvenir/#{souvenir.id}"
                    else 
                        redirect to "/souvenir/#{souvenir.id}/edit"
                    end
                else 
                    redirect to '/souvenirs'
                end
            end
        else
            redirect to '/login'
        end 
    end

    delete '/souvenir/:id/delete' do 
        if logged_in?
            @souvenir = Souvenir.find_by_id(params[:id])
            if @souvenir && souvenir.trip.user == current_user
                @souvenir.delete
            end
            redirect to '/souvenirs'
        else 
            redirect to '/login'
        end
    end
end