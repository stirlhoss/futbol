require 'simplecov'
SimpleCov.start
require 'pry'
require './lib/stat_tracker'

describe "StatTracker functionality" do
  before :each do
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

describe StatTracker do
  it "exists and gets data" do
    expect(@stat_tracker).to be_an_instance_of(StatTracker)
    expect(@stat_tracker.class).to eq(StatTracker)
    expect(@stat_tracker.games.class).to eq(Array)
    expect(@stat_tracker.games[0].game_id).to eq('2012030221')
  end
end


#====================
#League Spec Tests
#====================

  it "tests leagues" do
    expect(@stat_tracker.count_of_teams).to eq(32)
    expect(@stat_tracker.best_offense).to eq("Reign FC")
    expect(@stat_tracker.worst_offense).to eq("Utah Royals FC")
    expect(@stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
    expect(@stat_tracker.highest_scoring_home_team).to eq("Reign FC")
    expect(@stat_tracker.lowest_scoring_visitor).to eq("San Jose Earthquakes")
    expect(@stat_tracker.lowest_scoring_home_team).to eq("Utah Royals FC")
  end
#====================
#Game spec tests
#====================

    it "tests games" do
    expect(@stat_tracker.highest_total_score).to eq 11
    expect(@stat_tracker.lowest_total_score).to eq 0
    expect(@stat_tracker.percentage_home_wins).to eq 0.44
    expect(@stat_tracker.percentage_visitor_wins).to eq 0.36
    expect(@stat_tracker.percentage_ties).to eq 0.20
    expect(@stat_tracker.count_of_games_by_season).to eq({
      "20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355
      })
    expect(@stat_tracker.average_goals_per_game).to eq 4.22
    expect(@stat_tracker.average_goals_by_season).to eq({
      "20122013"=>4.12,
      "20162017"=>4.23,
      "20142015"=>4.14,
      "20152016"=>4.16,
      "20132014"=>4.19,
      "20172018"=>4.44
      })
    end

#====================
#Season spec tests
#====================


  it "tests seasons" do
    expect(@stat_tracker.winningest_coach("20132014")).to eq("Claude Julien")
    expect(@stat_tracker.worst_coach("20132014")).to eq("Ron Rolston")
    expect(@stat_tracker.most_accurate_team("20132014")).to eq("Real Salt Lake")
    expect(@stat_tracker.least_accurate_team("20132014")).to eq("New York City FC")
    expect(@stat_tracker.most_tackles("20132014")).to eq("FC Cincinnati")
    expect(@stat_tracker.fewest_tackles("20132014")).to eq("Atlanta United")
  end

#====================
#Team spec tests
#====================

  it 'team tests' do
    expect(@stat_tracker.team_info("1")).to eq({
      "abbreviation" => "ATL",
      "franchise_id" => "23",
      "link" => "/api/v1/teams/1",
      "team_id" => "1",
      "team_name" => "Atlanta United"
      })
    expect(@stat_tracker.best_season("5")).to eq("20162017")
    expect(@stat_tracker.worst_season("5")).to eq("20122013")
    expect(@stat_tracker.average_win_percentage("6")).to eq(0.49)
    expect(@stat_tracker.most_goals_scored("5")).to eq(6)
    expect(@stat_tracker.fewest_goals_scored("5")).to eq(0)
    expect(@stat_tracker.favorite_opponent("18")).to eq("DC United")
    expect(@stat_tracker.rival("5")).to eq("San Jose Earthquakes")
  end
end
