#runner.rb

require './lib/stat_tracker'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)
p stat_tracker.percentage_ties
p stat_tracker.percentage_home_wins
p stat_tracker.percentage_visitor_wins
p stat_tracker.count_of_games_by_season
p stat_tracker.average_goals_per_game
p stat_tracker.average_goals_by_season
p stat_tracker.lowest_total_score
p stat_tracker.highest_total_score
