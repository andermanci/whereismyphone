
class User < ApplicationRecord
  require 'digest/sha1'


  validates :username,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

  before_save :encrypt_password


  validates_presence_of :password, :on => :create
  validates_presence_of :email, :on => :create
  validates_presence_of :username, :on => :create
  validates_uniqueness_of :email
  validates_uniqueness_of :username

  has_many :devices, dependent: :destroy


  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password == Digest::SHA1.hexdigest(password)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password =  Digest::SHA1.hexdigest(password)
    end
  end

  def self.authenticate_by_email(email, password)
    user = find_by_email(email)
    if user && user.password == Digest::SHA1.hexdigest(password)
      user
    else
      nil
    end
  end




end