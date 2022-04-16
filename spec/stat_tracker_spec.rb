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

describe StatTracker functionality do
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

#====================
#Season spec tests
#====================


  it "can name coach with best season win percentage" do

    expect(@stat_tracker.winningest_coach(20132014)).to eq("Claude Julien")
  end

  it "can name coach with worst season win percentage" do
    expect(@stat_tracker.worst_coach(20132014)).to eq()
  end

  it "can name most accurate team" do
    expect(@stat_tracker.most_accurate_team(20132014)).to eq()
  end

  it "can name least accurate team" do
    expect(@stat_tracker.least_accurate_team(20132014)).to eq()
  end

  it "can name team with most tackles" do
    expect(@stat_tracker.most_tackles(20132014)).to eq()
  end

  it "can name team with fewest tackles" do
    expect(@stat_tracker.fewest_tackles(20132014)).to eq()
  end
end
