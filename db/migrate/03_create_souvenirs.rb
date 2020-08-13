class CreateSouvenirs < ActiveRecord::Migration[5.2]  
    def change    
        create_table :souvenirs do |t|      
            t.string :souvener_name      
            t.integer :trip_id    
        end  
    end 
end