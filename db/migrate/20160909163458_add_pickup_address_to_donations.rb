class AddPickupAddressToDonations < ActiveRecord::Migration[5.0]
  def change
    add_column :donations, :pickup_address, :string
  end
end
