# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Message.create(title: 'test title 1', content: 'test content 1')
#Message.create(title: 'test title 2', content: 'test content 2')
#Message.create(title: 'test title 3', content: 'test content 3')

(1..100).each do |number|
  User.create(name: 'testname ' + number.to_s, email: 'testemail ' + number.to_s + '@gmail.com', password_digest: '', created_at: '', updated_at: '' )
end

(1..10).each do |number|
  Micropost.create(content: 'test content' + number.to_s, user_id: number.to_s, created_at: '', updated_at: '')
end