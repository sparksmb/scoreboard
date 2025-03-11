require 'rails_helper'

RSpec.describe BaseballGame, type: :model do
  let(:game) { create(:baseball_game) }

  describe '#compute_action' do
    context 'with invalid action' do
      it 'raises ArgumentError' do
        expect { game.compute_action('invalid_action', {}) }.to raise_error(ArgumentError)
      end
    end

    context 'with homerun action' do
      let(:params) { { "home_score" => 0, "away_score" => 0 } }

      it 'clears all bases' do
        result = game.compute_action('homerun', params)
        expect(result["runner_on_first"]).to be false
        expect(result["runner_on_second"]).to be false
        expect(result["runner_on_third"]).to be false
      end

      it 'increases score based on runners' do
        game.update(runner_on_first: true, runner_on_second: true)
        result = game.compute_action('homerun', params)
        expect(result["away_score"]).to eq 3 # 2 runners + batter
      end
    end

    context 'with ball action' do
      let(:params) { { "balls" => game.balls } }

      it 'increases ball count' do
        result = game.compute_action('ball', params)
        expect(result["balls"]).to eq 1
      end

      it 'resets ball count after 4 balls' do
        game.update(balls: 3)
        result = game.compute_action('ball', params)
        expect(result["balls"]).to eq 0
      end
    end
  end

  describe '#batting_team' do
    it 'returns away team in top of inning' do
      game.update(inning_status: 'top')
      expect(game.batting_team).to eq 'away'
    end

    it 'returns home team in bottom of inning' do
      game.update(inning_status: 'bot')
      expect(game.batting_team).to eq 'home'
    end
  end

  describe '#base_runner_count' do
    it 'counts number of runners on base' do
      game.update(runner_on_first: true, runner_on_second: true)
      expect(game.base_runner_count).to eq 2
    end
  end
end 
