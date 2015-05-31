class City < ActiveRecord::Base

  has_many :transit_modes
  has_many :pics

  validates :name, :country, presence: true
  validates_uniqueness_of :name, scope: (:state ? [:country, :state] : :country)

end