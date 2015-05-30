class User < ActiveRecord::Base

  has_many :revisions
  has_many :pics, dependent: :destroy

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true
  

end
