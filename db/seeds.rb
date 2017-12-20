User.destroy_all
Location.destroy_all

User.create!(:first_name => "Mitch", :last_name => "Mele", :username => "mmele345", :email =>"mitch@gif-yo-weather.com", :password => "password123")
User.create!(:first_name => "Baska", :last_name => "Batbold", :username => "itsbaska", :email =>"baska@gif-yo-weather.com", :password => "password123")
User.create!(:first_name => "Melissa", :last_name => "Kanhirun", :username => "mk7run", :email =>"melissa@gif-yo-weather.com", :password => "password123")


locations = [
  { city: "Chicago",
    region: "IL",
    country: "USA"
  }, { city: "Omaha",
    region: "NE",
    country: "USA"
  }, { city: "New York",
    region: "NY",
    country: "USA"
  }, { city: "San Diego",
    region: "CA",
    country: "USA"
  }, { city: "Dallas",
    region: "TX",
    country: "USA"
  }, { city: "Seattle",
    region: "WA",
    country: "USA"
  }, { city: "Ulaanbaatar",
    region: "Ulaanbaatar",
    country: "Mongolia"
  }
]
  Location.create!(locations)

UserLocation.create!(location_id: 1, user_id: 1)
UserLocation.create!(location_id: 2, user_id: 1)
UserLocation.create!(location_id: 3, user_id: 2)
UserLocation.create!(location_id: 4, user_id: 2)
UserLocation.create!(location_id: 5, user_id: 3)
UserLocation.create!(location_id: 6, user_id: 3)
