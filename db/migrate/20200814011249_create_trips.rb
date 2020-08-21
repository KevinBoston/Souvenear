class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.string :destination
      t.integer :user_id
      t.string :date
      t.string :description
    end
  end
end
