class Revision < ActiveRecord::Base

  has_many :users
  has_many :transit_modes

  validates :column_name, presence: true

end