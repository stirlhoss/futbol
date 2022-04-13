require 'pry'
require 'csv'

class StatTracker
  attr_reader :stats
  def initialize(stats)
    @stats = stats
  end

  def self.from_csv(locations)
    info = []
    locations.each do |key, path|
      info << CSV.read(path, headers: true, header_converters: :symbol)
    end
    StatTracker.new(info)
  end

  def highest_total_score
    total = 0
    @stats[0].each do |row|
      if total < row[:home_goals].to_i + row[:away_goals].to_i
        total = row[:home_goals].to_i + row[:away_goals].to_i
      end
    end
    return total
  end

  def lowest_total_score
  end

  def percentage_home_wins
  end

  def percentage_visitor_wins
  end

  def percentage_ties
  end

  def count_of_games_by_season
  end

  def average_goals_per_game
  end

  def average_goals_by_season
  end

  # -----league statistics-------

  def count_of_teams
  end

  def best_offense
  end

  def worst_offense
  end

  def highest_scoring_visitor
  end

  def highest_scoring_home_team
  end

  def lowest_scoring_visitor
  end

  def lowest_scoring_home_team
  end

  # -----season statistics-------

  def winningest_coach
    coach_win_hash = Hash.new(0)
    coach_total_hash = Hash.new(0)
    @stats[2].each do |row|
      coach_win_hash[row[:head_coach]] += 1 if row[:result] == "WIN"
      coach_total_hash[row[:head_coach]] += 1
    end
    wphash = coach_win_hash.map {|key,value|[key, value.to_f / coach_total_hash[key].to_f]}
    wphash.max_by{|coach,percent| percent}[0]
  end

  def worst_coach
    coach_win_hash = Hash.new(0)
    coach_total_hash = Hash.new(0)
    @stats[2].each do |row|
      coach_win_hash[row[:head_coach]] += 1 if row[:result] == "WIN"
      coach_total_hash[row[:head_coach]] += 1
    end
    wphash = coach_win_hash.map {|key,value|[key, value.to_f / coach_total_hash[key].to_f]}
    wphash.min_by{|coach,percent| percent}[0]
  end

  def most_accurate_team
    shots_hash = Hash.new(0)
    goal_hash = Hash.new(0)
    @stats[2].each do |row|
      shots_hash[row[:team_id]] += row[:shots].to_i
      goal_hash[row[:team_id]] += row[:goals].to_i
    end
    ratio_hash = shots_hash.map {|key,value|[key, goal_hash[key].to_f / value.to_f]}
    team_id = ratio_hash.max_by{|id,percent| percent}[0]
    @stats[1].find {|row| row[:team_id] == team_id}[:teamname]
  end

  def least_accurate_team
    shots_hash = Hash.new(0)
    goal_hash = Hash.new(0)
    @stats[2].each do |row|
      shots_hash[row[:team_id]] += row[:shots].to_i
      goal_hash[row[:team_id]] += row[:goals].to_i
    end
    ratio_hash = shots_hash.map {|key,value|[key, goal_hash[key].to_f / value.to_f]}
    team_id = ratio_hash.min_by{|id,percent| percent}[0]
    @stats[1].find {|row| row[:team_id] == team_id}[:teamname]
  end

  def most_tackles
    tackles_hash = Hash.new(0)
    @stats[2].each do |row|
      tackles_hash[row[:team_id]] += row[:tackles].to_i
    end
    team_id = tackles_hash.max_by{|id,tackles| tackles}[0]
    @stats[1].find {|row| row[:team_id] == team_id}[:teamname]
  end

  def fewest_tackles
    tackles_hash = Hash.new(0)
    @stats[2].each do |row|
      tackles_hash[row[:team_id]] += row[:tackles].to_i
    end
    team_id = tackles_hash.min_by{|id,tackles| tackles}[0]
    @stats[1].find {|row| row[:team_id] == team_id}[:teamname]
  end

  # -----team statistics-------

  def team_info
  end

  def best_season
  end

  def worst_season
  end

  def average_win_percentage
  end

  def most_goals_scored
  end

  def fewest_goals_scored
  end

  def favorite_opponent
  end

  def rival
  end
end
