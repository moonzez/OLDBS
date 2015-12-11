require 'test_helper'

class WorkshopsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:workshops)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_workshop
    assert_difference('Workshop.count') do
      post :create, :workshop => { }
    end

    assert_redirected_to workshop_path(assigns(:workshop))
  end

  def test_should_show_workshop
    get :show, :id => workshops(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => workshops(:one).id
    assert_response :success
  end

  def test_should_update_workshop
    put :update, :id => workshops(:one).id, :workshop => { }
    assert_redirected_to workshop_path(assigns(:workshop))
  end

  def test_should_destroy_workshop
    assert_difference('Workshop.count', -1) do
      delete :destroy, :id => workshops(:one).id
    end

    assert_redirected_to workshops_path
  end
end
