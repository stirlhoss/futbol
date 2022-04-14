require 'pry'
require 'csv'

class StatTracker

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
   @stats[1].count
  end

  def best_offense
    best_o = Hash.new(0)
    game_counter = Hash.new(0)
    @stats[2].each do |row|
      best_o[row[:team_id]] += row[:goals].to_i
      game_counter[row[:team_id]] += 1
    end
    best_o.each do |team_id, goals|
      best_o[team_id] = goals / game_counter[team_id].to_f
    end
    team = best_o.max_by{ |key,value| value }[0]
    @stats[1].find{ |row| row[:team_id] == team }[:teamname]
  end

  def worst_offense
    worst_o = Hash.new(0)
    game_counter = Hash.new(0)
    @stats[2].each do |row|
      worst_o[row[:team_id]] += row[:goals].to_i
      game_counter[row[:team_id]] += 1
    end
    worst_o.each do |team_id, goals|
      worst_o[team_id] = goals / game_counter[team_id].to_f
    end
    team = worst_o.min_by{ |key,value| value }[0]
    @stats[1].find{ |row| row[:team_id] == team }[:teamname]
  end

  def highest_scoring_visitor
    best_away_o = Hash.new(0)
    game_counter = Hash.new(0)
    @stats[0].each do |row|
      best_away_o[row[:away_team_id]] += row[:away_goals].to_i
      game_counter[row[:away_team_id]] += 1
    end
    best_away_o.each do |team_id, goals|
      best_away_o[team_id] = goals/game_counter[team_id].to_f
    end
    team = best_away_o.max_by { |key, value| value }[0]
    @stats[1].find{ |row| row[:team_id] == team}[:teamname]
  end

  def highest_scoring_home_team
    best_home_o = Hash.new(0)
    game_counter = Hash.new(0)
    @stats[0].each do |row|
      best_home_o[row[:home_team_id]] += row[:home_goals].to_i
      game_counter[row[:home_team_id]] += 1
    end
    best_home_o.each do |team_id, goals|
      best_home_o[team_id] = goals/game_counter[team_id].to_f
    end
    team = best_home_o.max_by { |key, value| value }[0]
    @stats[1].find{ |row| row[:team_id] == team}[:teamname]
  end

  def lowest_scoring_visitor
    worst_away_o = Hash.new(0)
    game_counter = Hash.new(0)
    @stats[0].each do |row|
      worst_away_o[row[:away_team_id]] += row[:away_goals].to_i
      game_counter[row[:away_team_id]] += 1
    end
    worst_away_o.each do |team_id, goals|
      worst_away_o[team_id] = goals/game_counter[team_id].to_f
    end
    team = worst_away_o.min_by { |key, value| value }[0]
    @stats[1].find{ |row| row[:team_id] == team}[:teamname]
  end

  def lowest_scoring_home_team
    worst_home_o = Hash.new(0)
    game_counter = Hash.new(0)
    @stats[0].each do |row|
      worst_home_o[row[:home_team_id]] += row[:home_goals].to_i
      game_counter[row[:home_team_id]] += 1
    end
    worst_home_o.each do |team_id, goals|
      worst_home_o[team_id] = goals/game_counter[team_id].to_f
    end
    team = worst_home_o.min_by { |key, value| value }[0]
    @stats[1].find{ |row| row[:team_id] == team}[:teamname]
  end

  # -----season statistics-------

  def winningest_coach
  end

  def worst_coach
  end

  def most_accurate_team
  end

  def least_accurate_team
  end

  def most_tackles
  end

  def fewest_tackles
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
