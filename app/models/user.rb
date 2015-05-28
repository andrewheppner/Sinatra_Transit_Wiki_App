class User < ActiveRecord::Base

  has_many :revisions
  has_many :pics

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :username, presence: true

end