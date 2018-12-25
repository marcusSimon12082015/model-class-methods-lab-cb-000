class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    Classification.all
  end

  def self.longest
    joins("
    INNER JOIN boat_classifications bc ON classifications.id = bc.classification_id
    INNER JOIN boats b ON b.id = bc.boat_id
    WHERE b.length = (
    	SELECT MAX(length) FROM boats
    )
    ")
  end
end
