class AddDonationIdToFoods < ActiveRecord::Migration[5.0]
  def change
    add_reference :foods, :donation, foreign_key: true
  end
end
