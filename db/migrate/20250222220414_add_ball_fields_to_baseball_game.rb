class AddBallFieldsToBaseballGame < ActiveRecord::Migration[7.2]
  def change
    add_column :baseball_games, :balls, :integer, default: 0
    add_column :baseball_games, :strikes, :integer, default: 0
  end
end
