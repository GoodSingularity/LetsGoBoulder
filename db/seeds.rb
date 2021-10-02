
User.create(name: Faker::Name.name, email: "admin@development.com", password_digest: "development", archive: false)
for i in 1..10 do
  User.create(name: Faker::Name.name, email: Faker::Internet.email, password_digest: "test", archive: false)
end


for i in 1..5 do
  Route.create(name: Faker::Name.name, route_setter: User.first.name color: i, status: true, files: [])
end
