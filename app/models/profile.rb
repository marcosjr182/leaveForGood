class Profile < ApplicationRecord
	has_many :donations
	has_one :organization
	belongs_to :user

	def has_organization?
		return (not organization.nil?)
	end
end
