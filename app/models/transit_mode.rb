class TransitMode < ActiveRecord::Base

  has_many :revisions, dependent: :destroy
  belongs_to :city

end