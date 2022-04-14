require 'rspec'
require 'csv'
require './lib/stat_tracker'
require 'simplecov'
SimpleCov.start

RSpec.describe 'team_spec' do
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

  it "returns the info of a team" do
    expect(@stat_tracker.team_info("1")).to eq({
      abbreviation: "ATL",
      franchiseid: "23",
      link: "/api/v1/teams/1",
      stadium: "Mercedes-Benz Stadium",
      team_id: "1",
      teamname: "Atlanta United"
      })
  end

  xit "returns the best season for a given team" do
    expect(@stat_tracker.best_season("5")).to eq("20122016")
  end

  xit "can return the worst season for a given team" do
    expect(@stat_tracker.worst_season("5")).to eq("20122014")
  end

  xit "can return a teams average win percentage of all games for a team" do
    expect(@stat_tracker.average_win_percentage("5")).to eq(53.33)
  end

  xit "can return the highest number of goals a particular team has scored in a single game" do
    expect(@stat_tracker.most_goals_scored("5")).to eq(4)
  end

  xit "can return the lowest numer of goals a particular team has scored in a single game." do
    expect(@stat_tracker.fewest_goals_scored("5")).to eq(0)
  end

  xit "can return the name of the opponent that has the lowest win percentage against the given team" do
    expect(@stat_tracker.favorite_opponent("5")).to eq("14")
  end

  xit "can return the Name of the opponent that has the highest win percentage against the given team." do
    expect(@stat_tracker.rival("5")).to eq("6")
  end
end
