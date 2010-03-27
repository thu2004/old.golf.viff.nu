Factory.define :user do |f|
  f.sequence(:login) { |n| "user_#{n}"}
  f.email { |u| "#{u.login}@abc.com"}
  f.password "secret"
  f.password_confirmation { |u| u.password }
end

Factory.define :role_position do |f|
  f.association :user
  f.association :role
end

Factory.define :role do |f|
  f.sequence(:name) { |n| "role_#{n}"}
end