require 'minitest/autorun'
require_relative 'solution'  # Replace with the actual path

class Day11 < Minitest::Test
  GALAXIES =<<~DOC
    ...#......
    .......#..
    #.........
    ..........
    ......#...
    .#........
    .........#
    ..........
    .......#..
    #...#.....
  DOC

  def test_rows_without_galaxies
    assert_equal [3,7], GalaxiesMap.new(GALAXIES).rows_without_galaxies
  end

  def test_column_without_galaxies
    assert_equal [2,5,8], GalaxiesMap.new(GALAXIES).columns_without_galaxies
  end

  def test_distance_between_galaxies
    galaxies_map = GalaxiesMap.new(GALAXIES)
    assert_equal 15, galaxies_map.distance_between_galaxies(galaxies_map.galaxies[0], galaxies_map.galaxies[6])
    assert_equal 17, galaxies_map.distance_between_galaxies(galaxies_map.galaxies[2], galaxies_map.galaxies[5])
    assert_equal 5, galaxies_map.distance_between_galaxies(galaxies_map.galaxies[7], galaxies_map.galaxies[8])
  end

  def test_sum_distances
    assert_equal 374, GalaxiesMap.new(GALAXIES).sum_distances
  end

end