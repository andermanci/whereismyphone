
class Device < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 15 }
  validates :ip, presence: true,
            uniqueness: { case_sensitive: false }
  validates :info, presence: true, length: { maximum: 50 }

  validates_confirmation_of :ip
  validates_presence_of :ip, :on => :create
  validates_presence_of :name, :on => :create
  validates_presence_of :info, :on => :create
  validates_uniqueness_of :ip

  belongs_to :user

end