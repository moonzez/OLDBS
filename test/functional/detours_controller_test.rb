require 'test_helper'

class DetoursControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:detours)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_detour
    assert_difference('Detour.count') do
      post :create, :detour => { }
    end

    assert_redirected_to detour_path(assigns(:detour))
  end

  def test_should_show_detour
    get :show, :id => detours(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => detours(:one).id
    assert_response :success
  end

  def test_should_update_detour
    put :update, :id => detours(:one).id, :detour => { }
    assert_redirected_to detour_path(assigns(:detour))
  end

  def test_should_destroy_detour
    assert_difference('Detour.count', -1) do
      delete :destroy, :id => detours(:one).id
    end

    assert_redirected_to detours_path
  end
end
