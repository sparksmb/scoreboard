class BaseballGame < ApplicationRecord
  attr_accessor :action

  after_update_commit -> { broadcast_update }

  def broadcast_update
    BaseballGameChannel.broadcast_to("baseball_game", {
      html: ApplicationController.render(partial: "baseball_games/scoreboard", locals: { game: self })
    })
  end

  def compute_score_from_home_run
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
    first  = runner_on_first  ? "black" : "none"
    second = runner_on_second ? "black" : "none"
    third  = runner_on_third  ? "black" : "none"
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

end
