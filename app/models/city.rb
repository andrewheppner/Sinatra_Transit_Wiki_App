class City < ActiveRecord::Base

  has_many :transit_modes
  has_many :pics

end