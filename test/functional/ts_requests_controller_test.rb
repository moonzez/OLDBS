require 'test_helper'

class TsRequestsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:ts_requests)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_ts_request
    assert_difference('TsRequest.count') do
      post :create, :ts_request => { }
    end

    assert_redirected_to ts_request_path(assigns(:ts_request))
  end

  def test_should_show_ts_request
    get :show, :id => ts_requests(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => ts_requests(:one).id
    assert_response :success
  end

  def test_should_update_ts_request
    put :update, :id => ts_requests(:one).id, :ts_request => { }
    assert_redirected_to ts_request_path(assigns(:ts_request))
  end

  def test_should_destroy_ts_request
    assert_difference('TsRequest.count', -1) do
      delete :destroy, :id => ts_requests(:one).id
    end

    assert_redirected_to ts_requests_path
  end
end
