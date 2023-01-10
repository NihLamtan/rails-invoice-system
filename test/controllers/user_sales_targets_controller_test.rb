require "test_helper"

class UserSalesTargetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_sales_target = user_sales_targets(:one)
  end

  test "should get index" do
    get user_sales_targets_url
    assert_response :success
  end

  test "should get new" do
    get new_user_sales_target_url
    assert_response :success
  end

  test "should create user_sales_target" do
    assert_difference("UserSalesTarget.count") do
      post user_sales_targets_url, params: { user_sales_target: { target: @user_sales_target.target, user_id: @user_sales_target.user_id } }
    end

    assert_redirected_to user_sales_target_url(UserSalesTarget.last)
  end

  test "should show user_sales_target" do
    get user_sales_target_url(@user_sales_target)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_sales_target_url(@user_sales_target)
    assert_response :success
  end

  test "should update user_sales_target" do
    patch user_sales_target_url(@user_sales_target), params: { user_sales_target: { target: @user_sales_target.target, user_id: @user_sales_target.user_id } }
    assert_redirected_to user_sales_target_url(@user_sales_target)
  end

  test "should destroy user_sales_target" do
    assert_difference("UserSalesTarget.count", -1) do
      delete user_sales_target_url(@user_sales_target)
    end

    assert_redirected_to user_sales_targets_url
  end
end
