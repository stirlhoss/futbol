# game_class_spec.rb

require 'rspec'
require './lib/game'
require './lib/stat_tracker'

describe Game do
  it 'exists' do
    info = {
      :game_id => "2012030221",
      :season => "20122013",
      :type => "Postseason",
      :date_time => "5/16/13",
      :away_team_id => "3",
      :home_team_id => "6",
      :away_goals => "2",
      :home_goals => "3",
      :venue => "Toyota Stadium",
      :venue_link => "/api/v1/venues/null"
    }
    game = Game.new(info)
    expect(game).to be_an_instance_of Game
  end
end
