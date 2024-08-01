# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# Seed Admin User
admin = User.create!(name: 'Admin',
                     email: 'admin@gmail.com',
                     password: '123123',
                     password_confirmation: '123123',
                     role: 'admin')

# Generate a bunch of additional users.
users = []
99.times do |n|
  name = Faker::Name.name
  email = "user-#{n + 1}@gmail.com"
  password = '123123'
  users << User.new(name: name,
                    email: email,
                    password: password,
                    password_confirmation: password)
end

# Import users in batches
User.import users, batch_size: 50, validate: false

# Fetch first 6 created users
users = User.order(:created_at).limit(6)

# Generate microposts for the first 6 users
microposts = []
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each do |user|
    microposts << Micropost.new(content: content, user_id: user.id)
  end
end

# Import microposts in batches
Micropost.import microposts, batch_size: 50, validate: false

