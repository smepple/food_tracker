Factory.define :user do |f|
  f.username 'testuser%d'
  f.email '%{username}@example.com'
  f.password 'foobarbaz'
end

Factory.define :dish do |f|
  f.user { Factory :user }
  f.name 'test dish'
  f.description 'Aenean lacinia bibendum nulla sed consectetur.'
  f.eat_date Time.now.to_date
  f.prep_time 30
  f.category { Factory :category }
  f.source { Factory :source }
  f.source_page 1
end

Factory.define :category do |f|
  f.name 'test category'
end

Factory.define :source do |f|
  f.author { Factory :author }
  f.name 'test source'
  f.url 'http://www.someawesomecookbook.com/'
end

Factory.define :author do |f|
  f.firstname 'Jane'
  f.lastname 'Doe'
end