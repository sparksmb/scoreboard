# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_03_23_233725) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "baseball_games", force: :cascade do |t|
    t.string "home_team"
    t.string "home_mascot"
    t.string "home_bg_color"
    t.string "home_font_color"
    t.integer "home_score", default: 0
    t.string "away_team"
    t.string "away_mascot"
    t.string "away_bg_color"
    t.string "away_font_color"
    t.integer "away_score", default: 0
    t.integer "inning"
    t.string "inning_status"
    t.integer "outs"
    t.integer "pitch_count"
    t.integer "foul_balls"
    t.boolean "runner_on_first"
    t.boolean "runner_on_second"
    t.boolean "runner_on_third"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "balls", default: 0
    t.integer "strikes", default: 0
    t.boolean "show_base_runners", default: false
    t.string "home_bg_score_color"
    t.string "away_bg_score_color"
  end

  create_table "games", force: :cascade do |t|
    t.string "home_team"
    t.string "home_mascot"
    t.string "home_bg_color"
    t.string "home_font_color"
    t.string "home_score"
    t.string "away_team"
    t.string "away_mascot"
    t.string "away_bg_color"
    t.string "away_font_color"
    t.string "away_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
