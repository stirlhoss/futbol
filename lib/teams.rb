# lib/team.rb
class Team
  attr_reader :team_id,
              :franchiseid,
              :teamname,
              :abbreviation,
              :stadium,
              :link

  def initialize(info)
    @team_id = info[:team_id]
    @franchiseid = info[:franchiseid]
    @teamname = info[:teamname]
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
