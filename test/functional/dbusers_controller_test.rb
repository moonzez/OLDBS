require 'test_helper'

class DbusersControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:dbusers)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_dbuser
    assert_difference('Dbuser.count') do
      post :create, :dbuser => { }
    end

    assert_redirected_to dbuser_path(assigns(:dbuser))
  end

  def test_should_show_dbuser
    get :show, :id => dbusers(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => dbusers(:one).id
    assert_response :success
  end

  def test_should_update_dbuser
    put :update, :id => dbusers(:one).id, :dbuser => { }
    assert_redirected_to dbuser_path(assigns(:dbuser))
  end

  def test_should_destroy_dbuser
    assert_difference('Dbuser.count', -1) do
      delete :destroy, :id => dbusers(:one).id
    end

    assert_redirected_to dbusers_path
  end
end
