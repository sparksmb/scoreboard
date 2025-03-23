class AddScoreBgColorsToBaseballGames < ActiveRecord::Migration[7.2]
  def change
    add_column :baseball_games, :home_bg_score_color, :string
    add_column :baseball_games, :away_bg_score_color, :string
  end
end
