Factory.sequence :email do |n|
  "person#{n}@example.com"
end

Factory.sequence :nickname do |n|
  "person#{n}"
end

Factory.define :user do |u|
  u.nickname { Factory.next(:nickname) }
  u.email {|a| "#{a.nickname}@example.com" }
end
