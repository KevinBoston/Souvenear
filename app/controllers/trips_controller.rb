class TripsController < ApplicationController
    get '/account' do 
        if logged_in?
            @trips = Trip.all.map {|trip|trip.user.id == session[:id]}
            erb :'/trips/trips'
        else
            redirect to '/login'
        end
    end

    get '/trips/new' do 
        if logged_in?
            erb :'/trip/create_trip/'
        else
            redirect to '/login'
        end
    end

    post '/trips' do 
        if logged_in?
            if params[:destination] == "" || params[:destination] == nil
                redirect to '/trips/new'
            else
                @trip = current_user.trips.build(destination => params[:destination], user_id => session[user_id], description => params[:description])
                if @trip.save
                    redirect to '/trip/#{@trip.id}'
                else
                    redirect to '/trip/new'
                end
            end
        else
            redirect to '/login'
        end
    end

    get '/trip/:id' do 
        if logged_in?
            @trip = Trip.find_by_id(params[:id])
            erb :'/trips/view_trip'
        else
            redirect to '/login'
        end
    end

    get '/trip/:id/edit' do 
        if logged_in?
            @trip = Trip.find_by_id(params[:id])
            if @trip && @trip.user == current_user
                erb :'trip/edit_trip'
            else
                redirect to '/trips'
            end
        else
            redirect to '/login'
        end
    end

    patch '/tweets/:id' do 
        if logged_in?
            if params[:destination] == "" || params[:description] == ""
                redirect to "/tweets/#{params[:id]}/edit"
            else
                @trip = Trip.find_by_id(params[:id])
                if @trip && trip.user == current_user
                    if @trip.update(destination: params[:destination])
                        redirect to '/trips/#{@trip.id}'
                    else
                        redirect to '/trips/#{@trip.id}/edit'
                    end
                else
                    redirect to '/trips'
                end
            end
        else
            redirect to '/login'
        end
    end

    delete '/trips/:id/delete' do 
        if logged_in?
            @trip = Trip.find_by_id(params[:id])
            if @trip && @trip.user == current_user
                @trip.delete
            end
            redirect to '/trips'
        else
            redirect to '/login'
        end
    end
end