class CreateUsers < ActiveRecord::Migration[5.1]  
    def change    
        create_table :users do |t|      
            t.string :username      
            t.string :name      
            t.string :password_digest      
            t.integer :number_of_trips      
            t.bool :admin
        end  
    end
end