require "minitest/autorun"
require_relative "../lib/game_of_life_no_graphics"
require_relative "../lib/rules"
require "Matrix"

class GoL_noG < Minitest::Test
  def setup
  end

  def test_evaluate_gen
    rows = cols = 4
    gol = GoL_Rules.new(rows, cols)
    universe = Matrix[[0, 1, 0, 0], [0, 1, 1, 1], [0, 1, 1, 0], [0, 0, 1, 0]]
    new_universe = Matrix.build(rows, cols) { }
    expected_universe = Matrix[[1, 1, 0, 1], [0, 0, 0, 1], [1, 0, 0, 0], [0, 0, 1, 0]]
    resp = evaluate_gen(gol, universe, new_universe)
    assert_equal(resp, expected_universe)
  end

  def test_evaluate_gen2
    rows = cols = 5
    gol = GoL_Rules.new(rows, cols)
    universe = Matrix[[0, 0, 0, 0, 0], [0, 0, 1, 0, 0], [0, 0, 1, 0, 0], [0, 0, 1, 0, 0], [0, 0, 0, 0, 0]]
    new_universe = Matrix.build(rows, cols) { }
    expected_universe = Matrix[[0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 1, 1, 1, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]]
    resp = evaluate_gen(gol, universe, new_universe)
    assert_equal(resp, expected_universe)
  end

  def test_evaluate_gen3
    rows = cols = 6
    gol = GoL_Rules.new(rows, cols)
    universe = Matrix[[0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 1, 1, 1, 0], [0, 1, 1, 1, 0, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0]]
    new_universe = Matrix.build(rows, cols) { }
    expected_universe = Matrix[[0, 0, 0, 0, 0, 0], [0, 0, 0, 1, 0, 0], [0, 1, 0, 0, 1, 0], [0, 1, 0, 0, 1, 0], [0, 0, 1, 0, 0, 0], [0, 0, 0, 0, 0, 0]]
    resp = evaluate_gen(gol, universe, new_universe)
    assert_equal(resp, expected_universe)
  end
end
