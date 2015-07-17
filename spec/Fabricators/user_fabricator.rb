Fabricator(:user) do
  email {Faker::Internet.email}
  name {Faker::Name.name}
  password_digest {Faker::Lorem.word}
end