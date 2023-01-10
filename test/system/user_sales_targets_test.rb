require "application_system_test_case"

class UserSalesTargetsTest < ApplicationSystemTestCase
  setup do
    @user_sales_target = user_sales_targets(:one)
  end

  test "visiting the index" do
    visit user_sales_targets_url
    assert_selector "h1", text: "User sales targets"
  end

  test "should create user sales target" do
    visit user_sales_targets_url
    click_on "New user sales target"

    fill_in "Target", with: @user_sales_target.target
    fill_in "User", with: @user_sales_target.user_id
    click_on "Create User sales target"

    assert_text "User sales target was successfully created"
    click_on "Back"
  end

  test "should update User sales target" do
    visit user_sales_target_url(@user_sales_target)
    click_on "Edit this user sales target", match: :first

    fill_in "Target", with: @user_sales_target.target
    fill_in "User", with: @user_sales_target.user_id
    click_on "Update User sales target"

    assert_text "User sales target was successfully updated"
    click_on "Back"
  end

  test "should destroy User sales target" do
    visit user_sales_target_url(@user_sales_target)
    click_on "Destroy this user sales target", match: :first

    assert_text "User sales target was successfully destroyed"
  end
end
