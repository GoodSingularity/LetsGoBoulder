
User.create(name: Faker::Name.name, email: "admin@development.com", password_digest: "development", archive: false, phone_number: 667089810)
for i in 1..10 do
  User.create(name: Faker::Name.name, email: Faker::Internet.email, password_digest: "test", archive: false, phone_number: 667089810)
end


for i in 1..5 do
  Route.create(name: Faker::Name.name, route_setter: User.first.name, color: i, status: true, files: [])
end

all_users=User.all

for i in 1..5 do
  Ascend.create(user_id: User.first.id, likes: all_users.pluck(:id), archive: false, route_id: Route.first.id)
end
