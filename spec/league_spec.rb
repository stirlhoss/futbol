require 'simplecov'
SimpleCov.start
require 'rspec'
require './lib/stat_tracker'

describe StatTracker do
  before :each do
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
  it "counts teams" do
    expect(@stat_tracker.count_of_teams).to eq(33)
  end

  it "gets team with best offense" do
    expect(@stat_tracker.best_offense).to eq("FC Dallas")
  end

  it "gets team with worst offense" do
    expect(@stat_tracker.worst_offense).to eq("Sporting Kansas City")
  end

  it "gets team with highest avg away goals" do
    expect(@stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
  end

  it "gets team with highest avg home goals" do
    expect(@stat_tracker.highest_scoring_home_team).to eq("New York City FC")
  end

  it "gets team with lowest avg away goals" do
    expect(@stat_tracker.lowest_scoring_visitor).to eq("Sporting Kansas City")
  end

  it "gets team with lowest avg home goals" do
    expect(@stat_tracker.lowest_scoring_home_team).to eq("Sporting Kansas City")
  end
end
