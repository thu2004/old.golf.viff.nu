Factory.define :option do |f|
  f.sequence(:name) { |n| "option_#{n}"}
  f.sequence(:value) { |n| "value_#{n}"}
end