class Location < ApplicationRecord
  has_many :user_locations
  has_many :users, through: :user_locations

  validates :city, :region, presence: true
  validates :city, uniqueness: true

  def weather
    Weather.lookup_by_location(self.city, self.region)
  end
end
