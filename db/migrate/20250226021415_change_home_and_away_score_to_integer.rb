class ChangeHomeAndAwayScoreToInteger < ActiveRecord::Migration[7.2]
  def up
    # Change column type using SQL statement
    execute <<-SQL
      ALTER TABLE baseball_games
      ALTER COLUMN home_score TYPE integer USING home_score::integer;
    SQL

    execute <<-SQL
      ALTER TABLE baseball_games
      ALTER COLUMN away_score TYPE integer USING away_score::integer;
    SQL

    # Set a default value (PostgreSQL requires a separate command for this)
    change_column_default :baseball_games, :home_score, 0
    change_column_default :baseball_games, :away_score, 0
  end


  def down
    change_column :baseball_games, :home_score, :string
    change_column :baseball_games, :away_score, :string
  end
end
