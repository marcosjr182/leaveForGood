class CreateDonations < ActiveRecord::Migration[5.0]
  def change
    create_table :donations do |t|
      t.datetime :pickup_window_start
      t.datetime :pickup_window_end
      t.integer :vehicle
      t.text :comments
      t.boolean :anonymous, default: false
      t.references :user, foreign_key: true
      t.references :organization, foreign_key: true
      t.integer :recipient_id, foreign_key: true

      t.timestamps
    end
  end
end
