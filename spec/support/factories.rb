Factory.define :user do |f|
  f.username 'testuser%d'
  f.email '%{username}@example.com'
  f.password 'foobarbaz'
end