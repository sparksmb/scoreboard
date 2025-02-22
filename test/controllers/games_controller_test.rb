require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get games_show_url
    assert_response :success
  end

  test "should get edit" do
    get games_edit_url
    assert_response :success
  end

  test "should get update" do
    get games_update_url
    assert_response :success
  end

  test "should get scoreboard" do
    get games_scoreboard_url
    assert_response :success
  end
end
