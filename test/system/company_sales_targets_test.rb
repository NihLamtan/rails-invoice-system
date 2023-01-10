require "application_system_test_case"

class CompanySalesTargetsTest < ApplicationSystemTestCase
  setup do
    @company_sales_target = company_sales_targets(:one)
  end

  test "visiting the index" do
    visit company_sales_targets_url
    assert_selector "h1", text: "Company sales targets"
  end

  test "should create company sales target" do
    visit company_sales_targets_url
    click_on "New company sales target"

    fill_in "Company", with: @company_sales_target.company_id
    fill_in "Target", with: @company_sales_target.target
    click_on "Create Company sales target"

    assert_text "Company sales target was successfully created"
    click_on "Back"
  end

  test "should update Company sales target" do
    visit company_sales_target_url(@company_sales_target)
    click_on "Edit this company sales target", match: :first

    fill_in "Company", with: @company_sales_target.company_id
    fill_in "Target", with: @company_sales_target.target
    click_on "Update Company sales target"

    assert_text "Company sales target was successfully updated"
    click_on "Back"
  end

  test "should destroy Company sales target" do
    visit company_sales_target_url(@company_sales_target)
    click_on "Destroy this company sales target", match: :first

    assert_text "Company sales target was successfully destroyed"
  end
end
