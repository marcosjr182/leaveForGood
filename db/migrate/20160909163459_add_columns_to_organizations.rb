class AddColumnsToOrganizations < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :contact_email, :string
    add_column :organizations, :contact_phone, :string
    add_column :organizations, :accepts_donations, :boolean, default: false
  end
end
