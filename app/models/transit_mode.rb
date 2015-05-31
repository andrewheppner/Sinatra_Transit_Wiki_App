class TransitMode < ActiveRecord::Base

  has_many :revisions, dependent: :destroy
  belongs_to :city

  validates :icon, :name, presence: true

end