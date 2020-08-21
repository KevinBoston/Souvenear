class TripsController < ApplicationController
   
    get '/trips/new' do 
        if logged_in?
            erb :'trips/create_trip'
        else
            redirect to '/login'
        end
    end

    post '/trips' do 
        if logged_in?
            if params[:destination] == "" || params[:destination] == nil
                redirect to '/trips/new'
            else
                @trip = current_user.trips.build(destination: params[:destination], description: params[:description], date: params[:date])
                if @trip.save
                    redirect to "/trips/#{@trip.id}"
                else
                    redirect to '/trips/new'
                end
            end
        else
            redirect to '/login'
        end
    end

    get '/trips/:id' do 
        if logged_in?
            @trip = Trip.find_by_id(params[:id])
            erb :'/trips/view_trip'
        else
            redirect to '/login'
        end
    end

    get '/trips/:id/edit' do 
        if logged_in?
            @trip = Trip.find_by_id(params[:id])
            if @trip && @trip.user == current_user
                erb :'trips/edit_trip'
            else
                redirect to '/users/account'
            end
        else
            redirect to '/login'
        end
    end

    patch '/trips/:id' do 
        if logged_in?
            if params[:destination] == "" || params[:description] == "" || params[:date] == ""
                redirect to "/trips/#{params[:id]}/edit"
            else
                @trip = Trip.find_by_id(params[:id])
                if @trip && @trip.user == current_user
                    if @trip.update(destination: params[:destination], description: params[:description], date: params[:date])
                        redirect to "/trips/#{@trip.id}"
                    else
                        redirect to "/trips/#{@trip.id}/edit"
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
            redirect to '/account'
        else
            redirect to '/login'
        end
    end
end