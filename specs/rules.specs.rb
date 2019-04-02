require_relative "../lib/rules"
require "minitest/autorun"
require "Matrix"

class Game_of_life < Minitest::Test
  def setup
    @gol = GoL_Rules.new
  end

  def test_count_neighbors()
    universe = Matrix[[1, 0, 1, 0], [0, 0, 0, 1], [0, 1, 0, 0], [0, 0, 1, 1]]
    resp = @gol.count_neighbors(universe, 0, 0)
    assert_equal(resp, 2)
  end

  def test_count_neighbors2()
    universe = Matrix[[0, 1, 0, 0], [0, 1, 0, 1], [1, 1, 1, 1], [0, 1, 0, 0]]
    resp = @gol.count_neighbors(universe, 2, 3)
    assert_equal(resp, 3)
  end
end
