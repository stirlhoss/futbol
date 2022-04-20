# lib/game_teams.rb
require './lib/stat_tracker'

class GameTeams
  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              :settled_in,
              :head_coach,
              :goals,
              :shots,
              :tackles,
              :pim,
              :powerplayopprotunities,
              :powerplaygoals,
              :faceoffwinpercentage,
              :giveaways,
              :takeaways

  def initialize(info)
    @game_id = info[:game_id]
    @team_id = info[:team_id]
    @hoa = info[:hoa]
    @result = info[:result]
    @settled_in = info[:settled_in]
    @head_coach = info[:head_coach]
    @goals = info[:goals]
    @shots = info[:shots]
    @tackles = info[:tackles]
    @pim = info[:pim]
    @powerplayopprotunities = info[:powerplayopprotunities]
    @powerplaygoals = info[:powerplaygoals]
    @faceoffwinpercentage = info[:faceoffwinpercentage]
    @giveaways = info[:giveaways]
    @takeaways = info[:takeaways]
  end

  def self.game_build(stats)
    game_array = Array.new(0)
    stats[:game_teams].each do |row|
      game_array << GameTeams.new(row)
    end
    game_array
  end

end
