# lib/team.rb
require './lib/stat_tracker'

class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link

  def initialize(info)
    @team_id = info[:team_id]
    @franchise_id = info[:franchiseid]
    @team_name = info[:teamname]
    @abbreviation = info[:abbreviation]
    @stadium = info[:stadium]
    @link = info[:link]
  end

  def self.team_build(stats)
    team_array = Array.new(0)
    stats[:teams].each do |row|
      team_array << Team.new(row)
    end
    team_array
  end
end
