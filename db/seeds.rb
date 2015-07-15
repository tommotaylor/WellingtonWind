Category.create!([
{ name: "Windsurfing" },
{ name: "Kitesurfing" },
{ name: "Sailing" }])

Spot.create!([
{ name: "Worser Bay",
  :categories => Category.where(name: ['Windsurfing','Sailing'])
  },
{ name: "The Ditch - Kio Bay (West Side)",
  :categories => Category.where(name: 'Windsurfing')
  },
{ name: "The Ditch - Shark Bay (East Side)",
  :categories => Category.where(name: 'Windsurfing')
  }, 
{ name: "Plimmerton",
  :categories => Category.where(name:'Windsurfing')
  },
{ name: "Seatoun",
  :categories => Category.where(name: ['Windsurfing', 'Kitesurfing'])
  }])

