require 'rails_helper'

RSpec.describe "Baseball Game Scoreboard", type: :system do
  let!(:game) { create(:baseball_game) }

  before do
    driven_by(:headless_chrome)
  end

  it "displays the current game state" do
    visit edit_baseball_game_path(game)
    
    expect(page).to have_content("Inning:")
    expect(page).to have_field("baseball_game_inning", with: "1")
    expect(page).to have_field("baseball_game_balls", with: "0")
    expect(page).to have_field("baseball_game_strikes", with: "0")
    expect(page).to have_field("baseball_game_outs", with: "0")
  end

  it "updates the score when adding runs" do
    visit edit_baseball_game_path(game)
    
    find("a[data-action='inc_home_score']").click
    expect(page).to have_field("baseball_game_home_score", with: "1")
    
    find("a[data-action='inc_away_score']").click
    expect(page).to have_field("baseball_game_away_score", with: "1")
  end

  it "handles a homerun" do
    game.update(runner_on_first: true, runner_on_second: true)
    visit edit_baseball_game_path(game)
    
    find("a[data-action='homerun']").click
    
    expect(page).not_to have_field("baseball_game_runner_on_first", checked: true)
    expect(page).not_to have_field("baseball_game_runner_on_second", checked: true)
    expect(page).not_to have_field("baseball_game_runner_on_third", checked: true)
  end

  it "tracks ball count" do
    visit edit_baseball_game_path(game)
    
    3.times { find("a[data-action='ball']").click }
    expect(page).to have_field("baseball_game_balls", with: "3")
    
    find("a[data-action='ball']").click
    expect(page).to have_field("baseball_game_balls", with: "0")
  end
end 