class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins("INNER JOIN boats b ON b.captain_id = captains.id
      INNER JOIN boat_classifications bc ON bc.boat_id = b.id
      INNER JOIN classifications c ON bc.classification_id = c.id
      WHERE c.name = 'Catamaran'")
  end

  def self.sailors
    joins("INNER JOIN boats b ON b.captain_id = captains.id
      INNER JOIN boat_classifications bc ON bc.boat_id = b.id
      INNER JOIN classifications c ON bc.classification_id = c.id
      WHERE c.name = 'Sailboat'").distinct
  end

  def self.talented_seafarers
    ar = joins("INNER JOIN boats b ON b.captain_id = captains.id
           INNER JOIN boat_classifications bc ON bc.boat_id = b.id
           INNER JOIN classifications c ON bc.classification_id = c.id
           WHERE c.name = 'Motorboat'")
#           INTERSECT
#           SELECT COUNT(*) FROM captains
#           INNER JOIN boats b ON b.captain_id = captains.id
#                   INNER JOIN boat_classifications bc ON bc.boat_id = b.id
#                   INNER JOIN classifications c ON bc.classification_id = c.id
#                   WHERE c.name = 'Sailboat'")
  end

  def self.non_sailors
   ar = Boat.joins("INNER JOIN boat_classifications bc ON bc.boat_id = b.id
              INNER JOIN classifications c ON bc.classification_id = c.id
              WHERE c.name = 'Motorboat'").to_sql
   
  end
end
