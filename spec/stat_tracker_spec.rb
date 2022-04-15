require 'simplecov'
SimpleCov.start
require 'pry'
require './lib/stat_tracker'

describe StatTracker do
  it "exists" do
    stats = "game_id,team_id
    2012030221,3"
    stat = StatTracker.new(stats)
    expect(stat).to be_an_instance_of(StatTracker)
  end

  it "gets data from CSV" do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)
    expect(stat_tracker.class).to eq(StatTracker)
    expect(stat_tracker.stats.class).to eq(Array)
    expect(stat_tracker.stats[0].class).to eq(CSV::Table)
    expect(stat_tracker.stats[0][:game_id][0]).to eq('2012030221')
  end
end
