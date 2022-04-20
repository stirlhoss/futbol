require 'pry'
require 'csv'
require_relative '../lib/game'
require_relative '../lib/teams'
require_relative '../lib/game_teams'
class StatTracker
  # attr_reader :stats

  def initialize(stats)
    # @stats = stats
    @games = Game.game_build(stats)
    @teams = Team.team_build(stats)
    @game_teams = GameTeam.game_team_build(stats)
  end

  def self.from_csv(locations)
    info = {}
    locations.each do |key, path|
      info[key] = CSV.read(path, headers: true, header_converters: :symbol)
    end
    StatTracker.new(info)
  end

  def highest_total_score
    total = 0
    @games.each do |row|
      if total < row.home_goals.to_i + row.away_goals.to_i
        total = row.home_goals.to_i + row.away_goals.to_i
      end
    end
    return total
  end

  def lowest_total_score
    total = 1
    @games.each do |row|
      if total > row.home_goals.to_i + row.away_goals.to_i
        total = row.home_goals.to_i + row.away_goals.to_i
      end
    end
    return total
  end

  def percentage_home_wins
    games = 0
    home_wins = 0
    @games.each do |row|
      home_wins += 1 if row.home_goals > row.away_goals
      games += 1
    end
    return (home_wins.to_f / games).round(2)
  end

  def percentage_visitor_wins
    games = 0
    visitor_wins = 0
    @games.each do |row|
      visitor_wins += 1 if row.home_goals < row.away_goals
      games += 1
    end
    return (visitor_wins.to_f / games).round(2)
  end

  def percentage_ties
    games = 0
    tie_games = 0
    @games.each do |row|
      tie_games += 1 if row.home_goals == row.away_goals
      games += 1
    end
    return (tie_games.to_f / games).round(2)
  end

  def count_of_games_by_season
    games_by_seasons = Hash.new(0)
    @games.each do |row|
        games_by_seasons[row.season] += 1
      end
    return games_by_seasons
  end

  def average_goals_per_game
    games = 0
    goals = 0
    @games.each do |row|
      goals += row.away_goals.to_i + row.home_goals.to_i
      games += 1
    end
    return (goals.to_f / games).round(2)
  end

  def average_goals_by_season
    games_per_season = count_of_games_by_season
    avg_goals_by_seasons = Hash.new(0)
    goals = Hash.new(0)
    @games.each do |row|
      goals[row.season] += row.away_goals.to_i + row.home_goals.to_i
      avg_goals_by_seasons[row.season] = (goals[row.season].to_f / games_per_season[row.season]).round(2)
    end
    return avg_goals_by_seasons
  end


  # -----league statistics-------

  def count_of_teams
   @teams.count
  end

  def best_offense
    best_o = Hash.new(0)
    game_counter = Hash.new(0)
    @game_teams.each do |row|
      best_o[row.team_id] += row.goals.to_i
      game_counter[row.team_id] += 1
    end
    best_o.each do |team_id, goals|
      best_o[team_id] = goals / game_counter[team_id].to_f
    end
    team = best_o.max_by{ |key,value| value }[0]
    @teams.find{ |row| row.team_id == team }.teamname
  end

  def worst_offense
    worst_o = Hash.new(0); game_counter = Hash.new(0)

    @game_teams.each do |row|
      worst_o[row.team_id] += row.goals.to_i
      game_counter[row.team_id] += 1
    end
    worst_o.each do |team_id, goals|
      worst_o[team_id] = goals / game_counter[team_id].to_f
    end
    team = worst_o.min_by{ |key,value| value }[0]
    @teams.find{ |row| row.team_id == team }.teamname
  end

  def highest_scoring_visitor
    best_away_o = Hash.new(0)
    game_counter = Hash.new(0)
    @games.each do |row|
      best_away_o[row.away_team_id] += row.away_goals.to_i
      game_counter[row.away_team_id] += 1
    end
    best_away_o.each do |team_id, goals|
      best_away_o[team_id] = goals/game_counter[team_id].to_f
    end
    team = best_away_o.max_by { |key, value| value }[0]
    @teams.find{ |row| row.team_id == team}.teamname
  end

  def highest_scoring_home_team
    best_home_o = Hash.new(0)
    game_counter = Hash.new(0)
    @games.each do |row|
      best_home_o[row.home_team_id] += row.home_goals.to_i
      game_counter[row.home_team_id] += 1
    end
    best_home_o.each do |team_id, goals|
      best_home_o[team_id] = goals/game_counter[team_id].to_f
    end
    team = best_home_o.max_by { |key, value| value }[0]
    @teams.find{ |row| row.team_id == team}.teamname
  end

  def lowest_scoring_visitor
    worst_away_o = Hash.new(0)
    game_counter = Hash.new(0)
    @games.each do |row|
      worst_away_o[row.away_team_id] += row.away_goals.to_i
      game_counter[row.away_team_id] += 1
    end
    worst_away_o.each do |team_id, goals|
      worst_away_o[team_id] = goals/game_counter[team_id].to_f
    end
    team = worst_away_o.min_by { |key, value| value }[0]
    @teams.find{ |row| row.team_id == team}.teamname
  end

  def lowest_scoring_home_team
    worst_home_o = Hash.new(0)
    game_counter = Hash.new(0)
    @games.each do |row|
      worst_home_o[row.home_team_id] += row.home_goals.to_i
      game_counter[row.home_team_id] += 1
    end
    worst_home_o.each do |team_id, goals|
      worst_home_o[team_id] = goals/game_counter[team_id].to_f
    end
    team = worst_home_o.min_by { |key, value| value }[0]
    @teams.find { |row| row.team_id == team}.teamname
  end

  # -----season statistics-------

  def winningest_coach(season)
    coach_win_hash = Hash.new(0); coach_total_hash = Hash.new(0); game_id_hash = Hash.new(0)
    season_array = @games.find_all{|row| row.season == season}
    season_array.each do |game|
      game_id_hash[game.game_id] = 1
    end
    @game_teams.each do |row|
      if game_id_hash[row.game_id] == 1
        coach_win_hash[row.head_coach] += 1 if row.result == "WIN"
        coach_total_hash[row.head_coach] += 1
      end
    end
    wphash = coach_win_hash.map {|key,value|[key, value.to_f / coach_total_hash[key].to_f]}
    wphash.max_by {|coach,percent| percent}[0]
  end

  def worst_coach(season)
    coach_win_hash = Hash.new(0); coach_total_hash = Hash.new(0); game_id_hash = Hash.new(0)
    season_array = @games.find_all{|row| row.season == season}
    season_array.each do |game|
      game_id_hash[game.game_id] = 1
    end
    @game_teams.each do |row|
      if game_id_hash[row.game_id] == 1
        coach_win_hash[row.head_coach] += 1 if row.result == "WIN"
        coach_total_hash[row.head_coach] += 1
      end
    end
    wphash = coach_win_hash.map {|key,value|[key, value.to_f / coach_total_hash[key].to_f]}
    wphash.min_by{|coach,percent| percent}[0]
  end

  def most_accurate_team(season)
  shots_hash = Hash.new(0); goal_hash = Hash.new(0); game_id_hash = Hash.new(0)
  season_array = @games.find_all{|row| row.season == season}
  season_array.each do |game|
    game_id_hash[game.game_id] = 1
  end
  @game_teams.each do |row|
    if game_id_hash[row.game_id] == 1
      shots_hash[row.team_id] += row.shots.to_i
      goal_hash[row.team_id] += row.goals.to_i
    end
  end
  ratio_hash = shots_hash.map {|key,value|[key, goal_hash[key].to_f / value.to_f]}
  team_id = ratio_hash.max_by{|id,percent| percent}[0]
  @teams.find {|row| row.team_id == team_id}.teamname
  end

  def least_accurate_team(season)
    shots_hash = Hash.new(0); goal_hash = Hash.new(0); game_id_hash = Hash.new(0)
    season_array = @games.find_all{|row| row.season == season}
    season_array.each do |game|
      game_id_hash[game.game_id] = 1
    end
    @game_teams.each do |row|
      if game_id_hash[row.game_id] == 1
        shots_hash[row.team_id] += row.shots.to_i
        goal_hash[row.team_id] += row.goals.to_i
      end
    end
    ratio_hash = shots_hash.map {|key,value|[key, goal_hash[key].to_f / value.to_f]}
    team_id = ratio_hash.min_by{|id,percent| percent}[0]
    @teams.find {|row| row.team_id == team_id}.teamname
  end

  def most_tackles(season)
    tackles_hash = Hash.new(0); game_id_hash = Hash.new(0)
    season_array = @games.find_all{|row| row.season == season}
    season_array.each do |game|
      game_id_hash[game.game_id] = 1
    end
    @game_teams.each do |row|
      tackles_hash[row.team_id] += row.tackles.to_i if game_id_hash[row.game_id] == 1
    end
    team_id = tackles_hash.max_by{|id,tackles| tackles}[0]
    @teams.find {|row| row.team_id == team_id}.teamname
  end

  def fewest_tackles(season)
    tackles_hash = Hash.new(0); game_id_hash = Hash.new(0)
    season_array = @games.find_all{|row| row.season == season}
    season_array.each do |game|
      game_id_hash[game.game_id] = 1
    end
    @game_teams.each do |row|
      tackles_hash[row.team_id] += row.tackles.to_i if game_id_hash[row.game_id] == 1
    end
    team_id = tackles_hash.min_by{|id,tackles| tackles}[0]
    @teams.find {|row| row.team_id == team_id}.teamname
  end

  # -----team statistics-------

  def team_info(team_id)
    team_info_hash = Hash.new(0)
    team = @teams.find {|x| team_id == x.team_id}
    team_info_hash["abbreviation"] = team.abbreviation
    team_info_hash["franchise_id"] = team.franchiseid
    team_info_hash["link"] = team.link
    team_info_hash["team_id"] = team.team_id
    team_info_hash["team_name"] = team.teamname
    team_info_hash
  end

  def best_season(team_id)
    t_wins = Hash.new(0)
    game_counter = Hash.new(0)
    @games.each do |row|
      if team_id == row.away_team_id && row.away_goals > row.home_goals
        t_wins[row.season] +=1
      elsif team_id == row.home_team_id && row.away_goals < row.home_goals
        t_wins[row.season] +=1
      end
    end
    season = t_wins.max_by{|key, value| value}[0]
  end

  def worst_season(team_id)
    t_wins = Hash.new(0)
    game_counter = Hash.new(0)
    @games.each do |row|
      if team_id == row.away_team_id && row.away_goals > row.home_goals
        t_wins[row.season] +=1
      elsif team_id == row.home_team_id && row.away_goals < row.home_goals
        t_wins[row.season] +=1
      end
    end
    season = t_wins.min_by{|key, value| value}[0]
  end

  def average_win_percentage(team_id)
    t_games = 0
    t_wins = 0
    games_by_team = @game_teams
    games_by_team.each do |row|
      t_games += 1 if team_id == row.team_id
      t_wins += 1 if team_id == row.team_id && row.result == "WIN"
    end
    average = (t_wins.to_f / t_games).round(2)
  end

  def most_goals_scored(team_id)
    t_goals = Hash.new(0)
    # game_counter = Hash.new(0)
    @game_teams.each do |row|
      if team_id == row.team_id
        t_goals[row.game_id] = row.goals
      end
    end
    t_goals.max_by{|key, value| value}[1].to_i
  end

  def fewest_goals_scored(team_id)
    t_goals = Hash.new(0)
    # game_counter = Hash.new(0)
    @game_teams.each do |row|
      if team_id == row.team_id
        t_goals[row.game_id] = row.goals
      end
    end
    t_goals.min_by{|key, value| value}[1].to_i
  end

  def favorite_opponent(team_id)
    team_wins = Hash.new(0)
    team_total = Hash.new(0)
    @games.each do |row|
      if team_id == row.away_team_id
        team_wins[row.home_team_id] += 1 if row.home_goals < row.away_goals
        team_total[row.home_team_id] += 1
      elsif team_id == row.home_team_id
        team_wins[row.away_team_id] += 1 if row.away_goals < row.home_goals
        team_total[row.away_team_id] += 1
      end
    end
    wphash = team_wins.map {|key,value|[key, value.to_f / team_total[key].to_f]}
    favorite_team_id = wphash.max_by{|team,percent| percent}[0]
    @teams.find {|row| row.team_id == favorite_team_id}.teamname
  end

  def rival(team_id)
    team_wins = Hash.new(0)
    team_total = Hash.new(0)
    @games.each do |row|
      if team_id == row.away_team_id
        team_wins[row.home_team_id] += 1 if row.home_goals > row.away_goals
        team_total[row.home_team_id] += 1
      elsif team_id == row.home_team_id
        team_wins[row.away_team_id] += 1 if row.away_goals > row.home_goals
        team_total[row.away_team_id] += 1
      end
    end
    wphash = team_wins.map {|key,value|[key, value.to_f / team_total[key].to_f]}
    rival_team_id = wphash.max_by{|team,percent| percent}[0]
    @teams.find {|row| row.team_id == rival_team_id}.teamname
  end
end
