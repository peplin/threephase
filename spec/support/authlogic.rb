require "authlogic/test_case"

include Authlogic::TestCase
activate_authlogic

def login user=nil
  @current_user = user || Factory(:user)
  @current_user_session = UserSession.create @current_user
  UserSession.stubs(:find).returns(@current_user_session)
end

def login_as_admin
  login Factory(:admin_user)
end

def logout
  @user_session = nil
end
