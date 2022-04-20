require 'simplecov'
SimpleCov.start
require 'pry'
require './lib/stat_tracker'

describe StatTracker do
  it "exists" do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)
    expect(stat_tracker).to be_an_instance_of(StatTracker)
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
    expect(stat_tracker.games.class).to eq(Array)
    expect(stat_tracker.games[0].game_id).to eq('2012030221')
  end
end

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

#====================
#League Spec Tests
#====================

  it "counts teams" do
    expect(@stat_tracker.count_of_teams).to eq(32)
  end

  it "gets team with best offense" do
    expect(@stat_tracker.best_offense).to eq("Reign FC")
  end

  it "gets team with worst offense" do
    expect(@stat_tracker.worst_offense).to eq("Utah Royals FC")
  end

  it "gets team with highest avg away goals" do
    expect(@stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
  end

  it "gets team with highest avg home goals" do
    expect(@stat_tracker.highest_scoring_home_team).to eq("Reign FC")
  end

  it "gets team with lowest avg away goals" do
    expect(@stat_tracker.lowest_scoring_visitor).to eq("San Jose Earthquakes")
  end

  it "gets team with lowest avg home goals" do
    expect(@stat_tracker.lowest_scoring_home_team).to eq("Utah Royals FC")
  end

#====================
#Game spec tests
#====================

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

      expect(@stat_tracker.percentage_home_wins).to eq 0.44
    end
  end

  describe 'percentage_visitor_wins' do
    it 'returns the percentage of visitor wins' do

      expect(@stat_tracker.percentage_visitor_wins).to eq 0.36
    end
  end

  describe 'percentage_draws' do
    it 'returns the percentage of games that end in draws' do

      expect(@stat_tracker.percentage_ties).to eq 0.20
    end
  end

  describe 'count_of_games_by_season' do
    it 'returns a hash of season_id keys and all games associated with them' do

    expect(@stat_tracker.count_of_games_by_season).to eq({
      "20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355
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
        "20122013"=>4.12,
        "20162017"=>4.23,
        "20142015"=>4.14,
        "20152016"=>4.16,
        "20132014"=>4.19,
        "20172018"=>4.44
        })
    end
  end

#====================
#Season spec tests
#====================


  it "can name coach with best season win percentage" do

    expect(@stat_tracker.winningest_coach("20132014")).to eq("Claude Julien")
  end

  it "can name coach with worst season win percentage" do
    expect(@stat_tracker.worst_coach("20132014")).to eq("Ron Rolston")
  end

  it "can name most accurate team" do
    expect(@stat_tracker.most_accurate_team("20132014")).to eq("Real Salt Lake")
  end

  it "can name least accurate team" do
    expect(@stat_tracker.least_accurate_team("20132014")).to eq("New York City FC")
  end

  it "can name team with most tackles" do
    expect(@stat_tracker.most_tackles("20132014")).to eq("FC Cincinnati")
  end

  it "can name team with fewest tackles" do
    expect(@stat_tracker.fewest_tackles("20132014")).to eq("Atlanta United")
  end

#====================
#Team spec tests
#====================

  describe 'team tests' do
  it "returns the info of a team" do
    expect(@stat_tracker.team_info("1")).to eq({
      "abbreviation" => "ATL",
      "franchise_id" => "23",
      "link" => "/api/v1/teams/1",
      "team_id" => "1",
      "team_name" => "Atlanta United"
      })
    end
  end

  it "returns the best season for a given team" do
    expect(@stat_tracker.best_season("5")).to eq("20162017")
  end

  it "can return the worst season for a given team" do
    expect(@stat_tracker.worst_season("5")).to eq("20122013")
  end

  it "can return a teams average win percentage of all games for a team" do
    expect(@stat_tracker.average_win_percentage("6")).to eq(0.49)
  end

  it "can return the highest number of goals a particular team has scored in a single game" do
    expect(@stat_tracker.most_goals_scored("5")).to eq(6)
  end

  it "can return the lowest numer of goals a particular team has scored in a single game." do
    expect(@stat_tracker.fewest_goals_scored("5")).to eq(0)
  end

  it "can return the name of the opponent that has the lowest win percentage against the given team" do
    expect(@stat_tracker.favorite_opponent("18")).to eq("DC United")
  end

  it "can return the Name of the opponent that has the highest win percentage against the given team." do
    expect(@stat_tracker.rival("5")).to eq("San Jose Earthquakes")
  end
 end
