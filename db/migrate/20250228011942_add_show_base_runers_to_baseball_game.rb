class AddShowBaseRunersToBaseballGame < ActiveRecord::Migration[7.2]
  def change
    add_column :baseball_games, :show_base_runners, :boolean, default: false
  end
end
