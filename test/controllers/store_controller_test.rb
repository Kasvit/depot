require 'test_helper'
# encoding: utf-8

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select '#columns #side a', minimum: 4
    assert_select '#main .entry', 3
    assert_select	'h3', 'Programming Ruby 1.9'
    #assert_select	'.price', /\грн. [.\d]+\,\d\d/
  end

end
