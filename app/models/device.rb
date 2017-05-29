
class Device < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 15 }
  validates :token, presence: true,
            uniqueness: { case_sensitive: false }
  validates :info, presence: true, length: { maximum: 50 }

  validates_confirmation_of :token
  validates_presence_of :token, :on => :create
  validates_presence_of :name, :on => :create
  validates_presence_of :info, :on => :create
  validates_uniqueness_of :token

  belongs_to :user
  has_many :locations, dependent: :destroy

end