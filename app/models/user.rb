class User < ActiveRecord::Base

  attr_accessor :new_password, :new_password_confirmation

  has_many :revisions
  has_many :pics

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true

  validates_confirmation_of :new_password, :if=>:password_changed?

  before_save :hash_new_password, :if=>:password_changed?

  private

  def hash_new_password
    hashed_password = BCrypt::Password.create(@new_password)
    save
  end

  def password_changed?
    !@new_password.blank?
  end

  def self.authenticate(email, password)
    if user = find_by_email(email)
      if BCrypt::Password.new(user.hashed_password).is_password?(password)
        user
      end
    end
  end

end