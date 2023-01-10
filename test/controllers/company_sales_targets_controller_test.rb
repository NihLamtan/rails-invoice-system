require "test_helper"

class CompanySalesTargetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @company_sales_target = company_sales_targets(:one)
  end

  test "should get index" do
    get company_sales_targets_url
    assert_response :success
  end

  test "should get new" do
    get new_company_sales_target_url
    assert_response :success
  end

  test "should create company_sales_target" do
    assert_difference("CompanySalesTarget.count") do
      post company_sales_targets_url, params: { company_sales_target: { company_id: @company_sales_target.company_id, target: @company_sales_target.target } }
    end

    assert_redirected_to company_sales_target_url(CompanySalesTarget.last)
  end

  test "should show company_sales_target" do
    get company_sales_target_url(@company_sales_target)
    assert_response :success
  end

  test "should get edit" do
    get edit_company_sales_target_url(@company_sales_target)
    assert_response :success
  end

  test "should update company_sales_target" do
    patch company_sales_target_url(@company_sales_target), params: { company_sales_target: { company_id: @company_sales_target.company_id, target: @company_sales_target.target } }
    assert_redirected_to company_sales_target_url(@company_sales_target)
  end

  test "should destroy company_sales_target" do
    assert_difference("CompanySalesTarget.count", -1) do
      delete company_sales_target_url(@company_sales_target)
    end

    assert_redirected_to company_sales_targets_url
  end
end
