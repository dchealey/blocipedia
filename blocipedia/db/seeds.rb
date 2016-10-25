include Faker

  10.times do
    User.create!(
    email:    Faker::Internet.email,
    password: Faker::Internet.password,
    )
  end

  User.create!(
  email:    'admin@users.com',
  password: 'BlocTest',
  role:     'admin',
  )

  User.create!(
  email:    'standard@users.com',
  password: 'BlocTest',
  )

  User.create!(
    email:    'premium@users.com',
    password: 'BlocTest',
    role:     'premium',
  )

  users = User.all

  15.times do
    Article.create!(
      title: Faker::Lorem.sentence,
      body: Faker::Lorem.paragraph,
      user: users.sample
    )
  end
  Article = Artilce.all


puts "Seed finished"
puts "#{User.count} users created."
puts "#{Article.count} wikis created."