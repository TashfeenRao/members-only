require 'test_helper'

class UsersSigninTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test 'login in with invalid info' do
    get signin_path
    assert_template 'sessions/new'
    post signin_path, params: { session: { email: '', password: '' } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get signin_path
    assert flash.empty?
  end
end
