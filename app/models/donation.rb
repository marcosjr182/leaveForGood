class Donation < ApplicationRecord
	enum vehicle: [:car , :suv, :truck]
	enum status: [:on_hold, :confirmed, :canceled]

  belongs_to :user, required: false
  belongs_to :organization, required: false
  belongs_to :recipient, :class_name => "Organization", :foreign_key => "recipient_id",  required: false

  validates :pickup_window_start, :presence => true
  validates :pickup_window_end, :presence => true
  validates :pickup_address, :presence => true
  validates :vehicle, :presence => true
  
  def self.by_organization(id)
	  where('personal = False AND user_id = ?',
	  	id
	  ).order("updated_at DESC")
	end
    
  def self.by_person(id)
    where('personal = True AND user_id = ?',
      id
    ).order("updated_at DESC")
  end

  def self.unmatched
    
    where("recipient_id is NULL AND status = ?",
      Donation.statuses["confirmed"]
    ).order("updated_at DESC")
  end

  has_many :foods
end
