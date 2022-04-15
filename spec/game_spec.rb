require 'pry'
require 'rspec'
require './lib/stat_tracker'
# require './test_data/games.csv'

describe 'games' do
  before do
    game_path = './test_data/games.csv'
    team_path = './test_data/teams.csv'
    game_teams_path = './test_data/game_teams.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  describe 'highest total score' do
    it 'returns the highest sum of the teams goals' do

    expect(@stat_tracker.highest_total_score).to eq 6
    end
  end

  describe 'lowest total score' do
    it 'returns the lowest sum of the teams goals' do

      expect(@stat_tracker.lowest_total_score).to eq 1
    end
  end

  describe 'percentage_home_wins' do
    it 'returns the percentage of home wins' do

      expect(@stat_tracker.percentage_home_wins).to eq 65.00
    end
  end

  describe 'percentage_visitor_wins' do
    it 'returns the percentage of visitor wins' do

      expect(@stat_tracker.percentage_visitor_wins).to eq 25.00
    end
  end

  describe 'percentage_draws' do
    it 'returns the percentage of games that end in draws' do

      expect(@stat_tracker.percentage_ties).to eq 10.00
    end
  end

  describe 'count_of_games_by_season' do
    it 'returns a hash of season_id keys and all games associated with them' do

    expect(@stat_tracker.count_of_games_by_season).to eq({
      20122013 => 10,
      20122014 => 10
      })
    end
  end

  describe 'average_goals_per_game' do
    it 'averages the total number of goals per game' do

      expect(@stat_tracker.average_goals_per_game).to eq 3.80
    end
  end

  describe 'average_goals_by_season' do
    it 'averages the total number of goals and stores them in a hash by season' do
      expect(@stat_tracker.average_goals_by_season).to eq({
        20122013 => 3.70,
        20122014 => 3.90
        })
    end
  end
end
