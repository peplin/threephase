require "authlogic/test_case"

include Authlogic::TestCase
activate_authlogic

def login
  @current_user = Factory :user unless @current_user
  @current_user_session = UserSession.create @current_user
  UserSession.stubs(:find).returns(@current_user_session)
end

def login_as_admin
  @current_user = Factory(:admin_user)
  login
end

def logout
  @user_session = nil
end
