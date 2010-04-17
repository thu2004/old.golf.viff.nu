Factory.define :event do |f|
  f.sequence(:name) { |n| "event_#{n}"}
  f.max_participant 10
  f.start_at   5.days.ago.to_s(:db)
  f.end_at     1.days.ago.to_s(:db)
end
