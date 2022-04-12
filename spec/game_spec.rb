require 'pry'
require 'rspec'
require './lib/stat_tracker'
# require './test_data/games.csv'

describe 'highest total score' do
  before:each do
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
  it 'returns the highest sum of the teams goals' do
    expect(@stat_tracker.highest_total_score).to eq 6
  end
end

describe 'lowest total score' do
  before:each do
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
  it 'returns the lowest sum of the teams goals' do
    expect(@stat_tracker.lowest_total_score).to eq 1
  end
end
