require 'test_helper'

class ReferentsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:referents)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_referent
    assert_difference('Referent.count') do
      post :create, :referent => { }
    end

    assert_redirected_to referent_path(assigns(:referent))
  end

  def test_should_show_referent
    get :show, :id => referents(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => referents(:one).id
    assert_response :success
  end

  def test_should_update_referent
    put :update, :id => referents(:one).id, :referent => { }
    assert_redirected_to referent_path(assigns(:referent))
  end

  def test_should_destroy_referent
    assert_difference('Referent.count', -1) do
      delete :destroy, :id => referents(:one).id
    end

    assert_redirected_to referents_path
  end
end
