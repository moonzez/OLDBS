require 'test_helper'

class HtseminarsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:htseminars)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_htseminar
    assert_difference('Htseminar.count') do
      post :create, :htseminar => { }
    end

    assert_redirected_to htseminar_path(assigns(:htseminar))
  end

  def test_should_show_htseminar
    get :show, :id => htseminars(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => htseminars(:one).id
    assert_response :success
  end

  def test_should_update_htseminar
    put :update, :id => htseminars(:one).id, :htseminar => { }
    assert_redirected_to htseminar_path(assigns(:htseminar))
  end

  def test_should_destroy_htseminar
    assert_difference('Htseminar.count', -1) do
      delete :destroy, :id => htseminars(:one).id
    end

    assert_redirected_to htseminars_path
  end
end
