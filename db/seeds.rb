User.create([
{ name: "Tom Taylor",
  email: "tom@tom.com",
  password: "password" }])

Category.create!([
{ name: "Windsurfing" },
{ name: "Kitesurfing" },
{ name: "Sailing" }])

Spot.create!([
{ name: "Worser Bay",
  latitude: -41.313107,
  longitude: 174.828204,
  :categories => Category.where(name: ['Windsurfing','Sailing'])
  },
{ name: "The Ditch - Kio Bay (West Side)",
  latitude: -41.297917, 
  longitude: 174.805051,
  :categories => Category.where(name: 'Windsurfing')
  },
{ name: "The Ditch - Shark Bay (East Side)",
  latitude: -41.300401, 
  longitude: 174.817384,
  :categories => Category.where(name: 'Windsurfing')
  }, 
{ name: "Plimmerton",
  latitude: -41.086575, 
  longitude: 174.867419,
  :categories => Category.where(name:'Windsurfing')
  },
{ name: "Seatoun",
  latitude: -41.322959, 
  longitude: 174.835677,
  :categories => Category.where(name: ['Windsurfing', 'Kitesurfing'])
  }])

Favourite.create!([
{ user_id: 1,
  spot_id: 1,
  list_order: 1
  },
{ user_id: 1,
  spot_id: 2,
  list_order: 2 }])

