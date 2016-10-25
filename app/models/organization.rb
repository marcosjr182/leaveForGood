class Organization < ApplicationRecord
	belongs_to :user
	has_many :donations

	validates :name, :presence => true
  validates :address, :presence => true
  validates :phone, :presence => true
  validates :contact_name, :presence => true
  
end
