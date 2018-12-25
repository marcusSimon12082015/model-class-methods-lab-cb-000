class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    order('created_at').limit(5)
  end

  def self.dinghy
    where('length < 20')
  end

  def self.ship
    where('length >= 20')
  end

  def self.last_three_alphabetically
    order('name DESC').limit(3)
  end

  def self.without_a_captain
    where(captain_id: nil)
  end

  def self.sailboats
    joins("INNER JOIN boat_classifications bs ON bs.boat_id = boats.id
    INNER JOIN classifications c ON c.id = bs.classification_id
    AND c.name = 'Sailboat'")
  end

  def self.with_three_classifications
    select("boats.id, count(boat_classifications.boat_id)").joins(:boat_classifications).group('boats.id')
    .having("count(boat_classifications.boat_id) > ?",2)
  end
end
