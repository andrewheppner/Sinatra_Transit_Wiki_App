class Pic < ActiveRecord::Base
  belongs_to :user
  belongs_to :city

  validates :path, presence: true 
  validates :pic_title, presence: true, length: {within: 3..30}
end