require 'minitest/autorun'
require_relative 'solution'  # Replace with the actual path

class Day2 < Minitest::Test

  GAMES = [
    'Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green',
    'Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue',
    'Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red',
    'Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red',
    'Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green'
  ]
  def test_game_id
    GAMES.each_with_index do |game_string, idx|
      assert_equal Game.new(game_string).id, idx + 1
    end
  end

  def test_sets
    'Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green'
    assert_equal Game.new(GAMES[0]).sets.map(&:to_h), [
      { blue: 3, red: 4 },
      { red: 1, green: 2, blue: 6 },
      { green: 2 }
    ]
  end

  def test_is_valid
    assert_equal Game.new(GAMES[0]).is_valid?(red: 12, green: 13, blue: 14), true
    assert_equal Game.new(GAMES[1]).is_valid?(red: 12, green: 13, blue: 14), true
    assert_equal Game.new(GAMES[2]).is_valid?(red: 12, green: 13, blue: 14), false
    assert_equal Game.new(GAMES[3]).is_valid?(red: 12, green: 13, blue: 14), false
    assert_equal Game.new(GAMES[4]).is_valid?(red: 12, green: 13, blue: 14), true
  end

  def test_valid_games_sum
    total_set = { red: 12, green: 13, blue: 14 }
    assert_equal Game.valid_games_sum(GAMES, total_set), 8
  end

  def test_set_power
    assert_equal CubeSet.new("4 red, 2 green, 6 blue").power, 48
  end
end