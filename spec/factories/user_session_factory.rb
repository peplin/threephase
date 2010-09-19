Factory.define :user_session, :parent => :user do |s|
  s.remember_me true
end

Factory.define :admin_user_session, :parent => :user do |s|
end
