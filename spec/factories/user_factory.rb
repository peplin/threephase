Factory.sequence :email do |n|
  "person#{n}@example.com"
end

Factory.define :user do |u|
  u.email { Factory.next :email }
end
