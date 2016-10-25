class AddPersonalToDonations < ActiveRecord::Migration[5.0]
  def change
    add_column :donations, :personal, :boolean, default: true
  end
end
