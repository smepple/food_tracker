Factory.define :user do |f|
  f.username 'testuser%d'
  f.email '%{username}@example.com'
  f.password 'foobarbaz'
end

Factory.define :dish do |f|
  f.user { Factory :user }
  f.name 'test dish%d'
  f.description "Aenean lacinia bibendum nulla sed consectetur"
  f.eat_date Date.yesterday
  f.prep_time 30
  f.category { Factory :category }
  f.source { Factory :source }
  f.source_page 1
end

Factory.define :category do |f|
  f.name 'test category%d'
end

Factory.define :source do |f|
  f.author { Factory :author }
  f.name 'test source%d'
  f.url 'http://www.someawesomecookbook.com/'
end

Factory.define :author do |f|
  f.firstname 'Jane'
  f.lastname 'Doe'
end

Factory.define :comment do |f|
  f.dish { Factory :dish }
  f.user { Factory :user }
  f.content "Duis mollis, est non commodo luctus"
end