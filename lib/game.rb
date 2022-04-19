# lib/game.rb
require './lib/stat_tracker'

class Game < StatTracker
  attr_reader :stats,
              :game_id,
              :season,
              :type,
              :date_time,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :venue,
              :venue_link

  def initialize(info)
    @game_id = info[:game_id]
    @season = info[:season]
    @type = info[:type]
    @date_time = info[:date_time]
    @away_team_id = info[:away_team_id]
    @home_team_id = info[:home_team_id]
    @away_goals = info[:away_goals]
    @home_goals = info[:home_goals]
    @venue = info[:venue]
    @venue_link = info[:venue_link]
  end

  def self.game_build(stats)
    game_array = Array.new(0)
    stats[:games].each do |row|
      game_array << Game.new(row)
    end
    game_array
  end

end
