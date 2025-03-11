class BaseballGame < ApplicationRecord
  attr_accessor :action

  VALID_ACTIONS = %w[homerun ball strike out clear_count clear_all_counts walk inc_home_score inc_away_score].freeze

  validates :home_team, presence: true
  validates :away_team, presence: true

  after_update_commit -> { broadcast_update }

  def compute_action(action, params)
    raise ArgumentError, "Invalid action: #{action}" unless VALID_ACTIONS.include?(action)
    send("compute_#{action}", params)
  end

  def compute_homerun(params)
    new_score = compute_score_from_homerun
    params["#{batting_team}_score"] = new_score
    params["runner_on_first"] = false
    params["runner_on_second"] = false
    params["runner_on_third"] = false
    params
  end

  def compute_ball(params)
    params["balls"] = next_ball_count
    params
  end

  def compute_strike(params)
    params["strikes"] = next_strike_count
    params
  end

  def compute_out(params)
    params["outs"] = next_out_count
    params
  end

  def compute_clear_count(params)
    params["balls"] = 0
    params["strikes"] = 0
    params
  end

  def compute_clear_all_counts(params)
    params["balls"] = 0
    params["strikes"] = 0
    params["outs"] = 0
    params
  end

  def compute_inc_home_score(params)
    params["home_score"] = home_score + 1
    params
  end

  def compute_inc_away_score(params)
    params["away_score"] = away_score + 1
    params
  end

  def broadcast_update
    BaseballGameChannel.broadcast_to("baseball_game", {
      html: ApplicationController.render(partial: "baseball_games/scoreboard", locals: { game: self })
    })
  end

  def compute_score_from_homerun
    team = batting_team
    current_score = team == "home" ? home_score : away_score
    runners_scored = base_runner_count
    current_score + runners_scored + 1
  end

  def next_ball_count
    count = balls + 1
    if balls >= 3
      count = 0
    end
    count
  end

  def next_strike_count
    count = strikes + 1
    if strikes >= 2
      count = 0
    end
    count
  end

  def next_out_count
    count = outs + 1
    if outs >= 2
      count = 0
    end
    count
  end

  def batting_team
    case inning_status
    when "top" then "away"
    when "bot" then "home"
    end
  end

  def clear_count
    {
      balls: 0,
      strikes: 0,
      outs: 0
    }
  end

  def base_runner_count
    [
      runner_on_first,
      runner_on_second,
      runner_on_third
    ].count(true)
  end

  def base_runners_svg
    first  = runner_on_first  == true ? "black" : "none"
    second = runner_on_second == true ? "black" : "none"
    third  = runner_on_third  == true ? "black" : "none"
    svg = <<~SVG
      <svg width="300" height="200" viewBox="0 55 100 150" xmlns="http://www.w3.org/2000/svg">
        <g transform="translate(100,100)">
          <rect x="10"  y="10" width="60" height="60" stroke="black" fill="#{first}"  transform="rotate(45)" stroke-width="5"/>
          <rect x="-70" y="10" width="60" height="60" stroke="black" fill="#{second}" transform="rotate(45)" stroke-width="5"/>
          <rect x="-70" y="90" width="60" height="60" stroke="black" fill="#{third}"  transform="rotate(45)" stroke-width="5"/>
        </g>
      </svg>
    SVG
    encode(svg)
  end
  def encode(svg)
    svg.gsub("> <", "%3E%3C")
       .gsub("<", "%3C")
       .gsub(">", "%3E%0A")
       .gsub("#", "%23")
  end

  def compute_walk(update_params)
    # 000 = no runners on base
    # 111 = bases loaded
    # index 0 is 3rd base
    # index 1 is 2nd base
    # index 2 is 1st base
    # runners = "000"
    # runners[2] = true if update_params["runner_on_first"]
    # runners[1] = true if update_params["runner_on_second"]
    # runners[0] = true if update_params["runner_on_third"]
    # ap "Runners initialized"
    # ap runners

    # case runners
    # when "000" then "001"
    # when "001" then "011"
    # when "010" then "011"
    # when "011" then "111"
    # when "100" then "101"
    # when "101" then "111"
    # when "110" then "111"
    # when "111"
    #   update_params = compute_runs(1, update_params)
    #   "110"
    # end

    # ap "Runners moved"
    # ap runners

    # update_params["runner_on_first"]  = runners[2] ? true : false
    # update_params["runner_on_second"] = runners[1] ? true : false
    # update_params["runner_on_third"]  = runners[0] ? true : false

    update_params["runner_on_first"] = true
    ap "COMPUTE WALK>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    ap update_params

    update_params
  end

  def compute_runs(runs, update_params)
    key = "#{batting_team}_score"
    current_score = self[key]
    new_score = current_score + runs
    update_params[key] = new_score
  end
end
