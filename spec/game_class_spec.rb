# game_class_spec.rb

require 'rspec'
require './lib/game'
require './lib/stat_tracker'

describe Game do
  it 'exists' do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
    game = Game.new

    expect(game).to be_an_instance_of Game
  end
end
