# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
100.times do |n|
  
  # ユーザ自体の作成
  name = Faker::Name.name
  email = Faker::Internet.email + Faker::Code.isbn + '.' + Faker::Code.ean + '.com'
  uid = Faker::Code.isbn
  password = "password"
  User.create!(
    email: email,
    name: name,
    password: password,
    password_confirmation: password,
    uid: uid,
    )
  
  # メールでの認証
  user = User.last
  user.confirmed_at = Time.now
  user.save!
  
  
  # トピックの作成
  t = Topic.new
  t.content = Faker::DragonBall.character
  t.user_id = user.id
  t.save!
  
  # コメントの作成
  c = Comment.new
  c.user_id = user.id
  c.topic_id = t.id
  c.content = Faker::DragonBall.character
  c.save!
  
end