require 'test_helper'

class EngineersControllerTest < ActionController::TestCase
  setup do
    @engineer = engineers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:engineers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create engineer" do
    assert_difference('Engineer.count') do
      post :create, engineer: { age: @engineer.age, email: @engineer.email, encrypted_password: @engineer.encrypted_password, fb_uid: @engineer.fb_uid, github_uid: @engineer.github_uid, is_invitation_enabled: @engineer.is_invitation_enabled, job_history: @engineer.job_history, living__place: @engineer.living__place, name: @engineer.name, notes: @engineer.notes, phone_number: @engineer.phone_number, self_introduction: @engineer.self_introduction, status: @engineer.status }
    end

    assert_redirected_to engineer_path(assigns(:engineer))
  end

  test "should show engineer" do
    get :show, id: @engineer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @engineer
    assert_response :success
  end

  test "should update engineer" do
    patch :update, id: @engineer, engineer: { age: @engineer.age, email: @engineer.email, encrypted_password: @engineer.encrypted_password, fb_uid: @engineer.fb_uid, github_uid: @engineer.github_uid, is_invitation_enabled: @engineer.is_invitation_enabled, job_history: @engineer.job_history, living__place: @engineer.living__place, name: @engineer.name, notes: @engineer.notes, phone_number: @engineer.phone_number, self_introduction: @engineer.self_introduction, status: @engineer.status }
    assert_redirected_to engineer_path(assigns(:engineer))
  end

  test "should destroy engineer" do
    assert_difference('Engineer.count', -1) do
      delete :destroy, id: @engineer
    end

    assert_redirected_to engineers_path
  end
end
