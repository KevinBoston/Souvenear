class CreateTrips < ActiveRecord::Migration[5.1]  
    def change    
        create_table :trips do |t|      
            t.string :destination      
            t.integer :user_id      
            t.integer :num_of_souvenirs      
            t.string :description    
        end 
    end 
end