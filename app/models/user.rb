class User < ActiveRecord::Base  
    has_secure_password  
    has_many :trips  
    has_many :souvenirs through :trips
end