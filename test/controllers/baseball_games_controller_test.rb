require "test_helper"

class BaseballGamesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get baseball_games_show_url
    assert_response :success
  end

  test "should get edit" do
    get baseball_games_edit_url
    assert_response :success
  end

  test "should get update" do
    get baseball_games_update_url
    assert_response :success
  end

  test "should get scoreboard" do
    get baseball_games_scoreboard_url
    assert_response :success
  end
end
