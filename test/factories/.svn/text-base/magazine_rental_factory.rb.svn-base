Factory.define :magazine_subscription do |f|
  f.sequence(:name) { |n| "magazine_subscription_#{n}" }  
  f.description "description" 
end

Factory.define :magazine_number do |f|
  f.sequence(:name) { |n| "magazine_number#{n}" }  
  f.num_of_copy 1
  f.association :magazine_subscription
end    

Factory.define :rental_subscription do |f|
  f.association :user
  f.association :magazine_subscription
end

Factory.define :rental_queue do |f|
  f.association :magazine_number
  f.association :user
end

Factory.define :rental_history do |f|
  f.rent_on   5.days.ago.to_s(:db)
  f.return_on 1.days.ago.to_s(:db)
end

Factory.define :rental do |f|
  f.association :user
end