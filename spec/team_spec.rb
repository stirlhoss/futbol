require 'rspec'
require 'csv'
require './lib/stat_tracker'
require 'simplecov'
SimpleCov.start

describe 'team_spec' do
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

  it 'returns the info of a team' do
    expect(@stat_tracker.team_info("1")).to eq({
      team_id: "1",
      franchiseId: "23",
      teamName: "Atlanta United",
      abbreviation: "ATL",
      link: "/api/v1/teams/1",
      Stadium: "Mercedes-Benz Stadium"
      })
  end
end
