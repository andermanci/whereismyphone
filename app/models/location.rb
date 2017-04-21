class Location < ApplicationRecord

  validates :long, presence: true, length: { maximum: 50 }
  validates :lat,  presence: true, length: { maximum: 50 }



  validates_confirmation_of :long, :lat
  validates_presence_of :long, :on => :create
  validates_presence_of :lat, :on => :create

  belongs_to :device

end