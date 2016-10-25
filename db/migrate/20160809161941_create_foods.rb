class CreateFoods < ActiveRecord::Migration[5.0]
  def change
    create_table :foods do |t|
      t.string :name
      t.integer :food_type
      t.integer :qty

      t.timestamps
    end
  end
end
