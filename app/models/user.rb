class User < ActiveRecord::Base

  attr_accessor :password, :password_confirmation

  has_many :revisions
  has_many :pics

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true

  validates_confirmation_of :password, :if=>:password_changed?

  before_save :hash_new_password, :if=>:password_changed?

  private

  def hash_new_password
    self.hashed_password = BCrypt::Password.create(password)
  end

  def password_changed?
    !@password.blank?
  end

  def self.authenticate(email, password)
    if user = find_by_email(email)
      if BCrypt::Password.new(user.hashed_password).is_password?(password)
        user
      end
    end
  end

end