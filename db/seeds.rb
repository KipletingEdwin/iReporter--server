# db/seeds.rb

# Create test users
admin = User.create!(
  name: "Admin User",
  email: "admin@test.com",
  password: "password",
  password_confirmation: "password",
  admin: true
)

user = User.create!(
  name: "Regular User",
  email: "user@test.com",
  password: "password",
  password_confirmation: "password",
  admin: false
)

# Create sample reports
Report.create!(
  title: "Broken Streetlight",
  description: "The streetlight on 5th Avenue is broken and needs repair.",
  location: "5th Avenue",
  status: "draft",
  user: user
)

Report.create!(
  title: "Pothole",
  description: "Large pothole near the park entrance.",
  location: "Central Park",
  status: "submitted",
  user: admin
)

puts "Seed data created!"
