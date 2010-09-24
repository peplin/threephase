Factory.sequence :email do |n|
  "person#{n}@example.com"
end

Factory.define :user do |u|
end

Factory.define :admin_user, :class => "User" do |u|
  u.admin true
end
