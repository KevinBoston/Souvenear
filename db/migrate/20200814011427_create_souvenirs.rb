class CreateSouvenirs < ActiveRecord::Migration[5.2]
  def change
    create_table :souvenirs do |t|
      t.string :souvenirname
      t.integer :trip_id
    end
  end
end
