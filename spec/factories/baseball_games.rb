FactoryBot.define do
  factory :baseball_game do
    home_team { "Home Team" }
    away_team { "Away Team" }
    home_score { 0 }
    away_score { 0 }
    inning { 1 }
    inning_status { "top" }
    balls { 0 }
    strikes { 0 }
    outs { 0 }
    runner_on_first { false }
    runner_on_second { false }
    runner_on_third { false }
  end
end 