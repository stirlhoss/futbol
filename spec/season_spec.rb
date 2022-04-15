require 'rspec'
require 'simplecov'
require './lib/season'


describe Season do
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

  it "can name coach with best season win percentage" do

    expect(@stat_tracker.winningest_coach).to eq("Claude Julien")
  end

  xit "can name coach with worst season win percentage" do
    expect(@stat_tracker.worst_coach).to eq()
  end

  xit "can name most accurate team" do
    expect(@stat_tracker.most_accurate_team).to eq()
  end

  xit "can name least accurate team" do
    expect(@stat_tracker.least_accurate_team).to eq()
  end

  xit "can name team with most tackles" do
    expect(@stat_tracker.most_tackles).to eq()
  end

  xit "can name team with fewest tackles" do
    expect(@stat_tracker.fewest_tackles).to eq()
  end  
end
