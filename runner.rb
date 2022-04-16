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

p stat_tracker.winningest_coach(20132014)
p stat_tracker.worst_coach(20132014)
p stat_tracker.most_accurate_team(20132014)
p stat_tracker.least_accurate_team(20132014)
p stat_tracker.most_tackles(20132014)
p stat_tracker.fewest_tackles(20132014)
