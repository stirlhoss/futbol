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

  def team_info(team_id)
    team_info_hash = Hash.new(0)
    @stats[1].each do |row|
      row.each do |column, value|
        team_info_hash[column] = value if team_id == row[:team_id]
      end
    end
    return team_info_hash
  end

  def best_season(team_id)
    t_wins = Hash.new(0)
    game_counter = Hash.new(0)
    @stats[0].each do |row|
      if team_id == row[:away_team_id] && row[:away_goals] > row[:home_goals]
        t_wins[row[:season]] +=1
      elsif team_id == row[:home_team_id] && row[:away_goals] < row[:home_goals]
        t_wins[row[:season]] +=1
      end
    end
    season = t_wins.max_by{|key, value| value}[0]
  end

  def worst_season(team_id)

  end

  def average_win_percentage(team_id)
    t_games = 0
    t_wins = 0
    games_by_team = @stats[2]
    games_by_team.each do |row|
      t_games += 1 if team_id == row[:team_id]
      t_wins += 1 if team_id == row[:team_id] && row[:result] == "WIN"
    end
    average = ((t_wins.to_f / t_games) * 100).round(2)
  end

  def most_goals_scored
  end

  def fewest_goals_scored(team_id)
  end

  def favorite_opponent
  end

  def rival
  end
end
