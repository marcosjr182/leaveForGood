class CreateOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :contact_name
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
