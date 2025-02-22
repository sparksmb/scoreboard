class CreateGames < ActiveRecord::Migration[7.2]
  def change
    create_table :games do |t|
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

      t.timestamps
    end
  end
end
