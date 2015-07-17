Fabricator(:user) do
  email {Faker::Internet.email}
  name {Faker::Name.name}
  password {Faker::Lorem.word}
end