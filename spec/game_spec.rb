require 'pry'
require 'rspec'
require './lib/stat_tracker'
# require './test_data/games.csv'

describe 'games' do
  before do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  describe 'highest total score' do
    it 'returns the highest sum of the teams goals' do

    expect(@stat_tracker.highest_total_score).to eq 11
    end
  end

  describe 'lowest total score' do
    it 'returns the lowest sum of the teams goals' do

      expect(@stat_tracker.lowest_total_score).to eq 0
    end
  end

  describe 'percentage_home_wins' do
    it 'returns the percentage of home wins' do

      expect(@stat_tracker.percentage_home_wins).to eq 43.50
    end
  end

  describe 'percentage_visitor_wins' do
    it 'returns the percentage of visitor wins' do

      expect(@stat_tracker.percentage_visitor_wins).to eq 36.11
    end
  end

  describe 'percentage_draws' do
    it 'returns the percentage of games that end in draws' do

      expect(@stat_tracker.percentage_ties).to eq 20.39
    end
  end

  describe 'count_of_games_by_season' do
    it 'returns a hash of season_id keys and all games associated with them' do

    expect(@stat_tracker.count_of_games_by_season).to eq({
      20122013=>806,
      20162017=>1317,
      20142015=>1319,
      20152016=>1321,
      20132014=>1323,
      20172018=>1355
      })
    end
  end

  describe 'average_goals_per_game' do
    it 'averages the total number of goals per game' do

      expect(@stat_tracker.average_goals_per_game).to eq 4.22
    end
  end

  describe 'average_goals_by_season' do
    it 'averages the total number of goals and stores them in a hash by season' do
      expect(@stat_tracker.average_goals_by_season).to eq({
        20122013=>4.12,
        20162017=>4.23,
        20142015=>4.14,
        20152016=>4.16,
        20132014=>4.19,
        20172018=>4.44
        })
    end
  end
end
