# lib/game.rb
require './lib/stat_tracker'

class Game < StatTracker

  def initialize
    @stats = super(stats)
    binding.pry
    @game_id = @stats[:games][:game_id]
    @season = @stats[:games][:season]
    @type = @stats[:games][:type]
    @date_time = @stats[:games][:date_time]
    @away_team_id = @stats[:games][:away_team_id]
    @home_team_id = @stats[:games][:home_team_id]
    @away_goals = @stats[:games][:away_goals]
    @home_goals = @stats[:games][:home_goals]
    @venue = @stats[:games][:venue]
    @venue_link = @stats[:games][:venue_link]
  end

  def self.from_csv(path)
    game_array = Array.new(0)

    game_array << Game.new()
  end
end
