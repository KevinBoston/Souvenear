class Trip < ActiveRecord::Base
    belongs_to :user
    has_many :souvenirs, dependent: :destroy
end