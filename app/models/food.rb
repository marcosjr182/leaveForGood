class Food < ApplicationRecord
	FOOD_TYPES = ["Cannade Food",
							  "Packaged Food",
							  "Cooked Food",
								"Produce"]

	belongs_to :donation
	
	validates :name, :presence => true
  validates :food_type, :presence => true
  validates :qty, :presence => true
  
end
