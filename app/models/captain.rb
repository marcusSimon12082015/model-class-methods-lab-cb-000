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
    select(:name).joins("INNER JOIN boats b ON captains.id = b.captain_id
              INNER JOIN boat_classifications bc ON bc.boat_id = b.id
              INNER JOIN classifications c ON bc.classification_id = c.id
              WHERE c.name IN('Sailboat','Motorboat')")
              .group("captains.name").having("COUNT(DISTINCT(c.name)) > ?",1);
  end

  def self.non_sailors
    select(:id,:name).joins("
    inner join Boats b on c.id = b.capitan_id
    inner join BoatClassifications bc on b.id = bc.boat_id
    inner join Classifications cl on bc.classification_id = cl.id
    WHERE NOT EXISTS
    (
      select c1.name,b1.name,cl1.name from Capitans c1
      inner join Boats b1 on c1.id = b1.capitan_id
      inner join BoatClassifications bc1 on b1.id = bc1.boat_id
      inner join Classifications cl1 on bc1.classification_id = cl1.id
      WHERE c1.id = c.id AND cl1.name = 'Sailboat'
      )").group("captains.id, captains.name")
  end
end
