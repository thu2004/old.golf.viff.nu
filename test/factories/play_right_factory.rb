Factory.define :play_right do |f|
  f.sequence(:name) { |n| "play_right_#{n}"}
  f.num_of_resource 4
  f.weekend_allow false
end

Factory.define :play_right_booking do |f|
   f.association :play_right
   f.association :user
   f.num_of_resource 1
   f.booked_on  2.days.from_now.to_s(:db)
end