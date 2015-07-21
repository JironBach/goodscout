require 'test_helper'

class EnginnersControllerTest < ActionController::TestCase
  setup do
    @enginner = enginners(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:enginners)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create enginner" do
    assert_difference('Enginner.count') do
      post :create, enginner: { age: @enginner.age, email: @enginner.email, encrypted_password: @enginner.encrypted_password, fb_uid: @enginner.fb_uid, github_uid: @enginner.github_uid, is_registration_enabled: @enginner.is_registration_enabled, job_history: @enginner.job_history, living_place: @enginner.living_place, name: @enginner.name, notes: @enginner.notes, phone_number: @enginner.phone_number, self_introduction: @enginner.self_introduction, status: @enginner.status }
    end

    assert_redirected_to enginner_path(assigns(:enginner))
  end

  test "should show enginner" do
    get :show, id: @enginner
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @enginner
    assert_response :success
  end

  test "should update enginner" do
    patch :update, id: @enginner, enginner: { age: @enginner.age, email: @enginner.email, encrypted_password: @enginner.encrypted_password, fb_uid: @enginner.fb_uid, github_uid: @enginner.github_uid, is_registration_enabled: @enginner.is_registration_enabled, job_history: @enginner.job_history, living_place: @enginner.living_place, name: @enginner.name, notes: @enginner.notes, phone_number: @enginner.phone_number, self_introduction: @enginner.self_introduction, status: @enginner.status }
    assert_redirected_to enginner_path(assigns(:enginner))
  end

  test "should destroy enginner" do
    assert_difference('Enginner.count', -1) do
      delete :destroy, id: @enginner
    end

    assert_redirected_to enginners_path
  end
end
