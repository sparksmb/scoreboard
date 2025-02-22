class CreateBaseballGames < ActiveRecord::Migration[7.2]
  def change
    create_table :baseball_games do |t|
      t.string :home_team
      t.string :home_mascot
      t.string :home_bg_color
      t.string :home_font_color
      t.string :home_score
      t.string :away_team
      t.string :away_mascot
      t.string :away_bg_color
      t.string :away_font_color
      t.string :away_score
      t.integer :inning
      t.string :inning_status
      t.integer :outs
      t.integer :pitch_count
      t.integer :foul_balls
      t.boolean :runner_on_first
      t.boolean :runner_on_second
      t.boolean :runner_on_third

      t.timestamps
    end
  end
end
