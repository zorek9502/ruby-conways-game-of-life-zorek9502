require "gosu"
require_relative "../lib/rules"
require "Matrix"

class Game_of_life < Gosu::Window
  @width_screen
  @height_screen
  @resolution
  @@universe
  @@new_universe
  @@speed = 1

  def initialize
    @width_screen = 100
    @height_screen = 100
    @resolution = 20
    super @width_screen, @height_screen
    self.caption = "Game of life"
    @@rows = @height_screen / @resolution
    @@cols = @width_screen / @resolution
    @gol = GoL_Rules.new(@@rows, @@cols)
    @@universe = Matrix[[0, 0, 0, 0, 0], [0, 0, 1, 0, 0], [0, 0, 1, 0, 0], [0, 0, 1, 0, 0], [0, 0, 0, 0, 0]]
    @@new_universe = Matrix.build(@@rows, @@cols) { }
  end

  def update
    @@universe.each_with_index do |x, i, j|
      neighbors = @gol.count_neighbors(@@universe, i, j)
      new_cell_state = @gol.live_or_die(x, neighbors)
      @@new_universe.send(:[]=, i, j, new_cell_state)
    end
    assign()
    sleep @@speed
  end

  def draw
    (0...@@rows).each do |i|
      (0...@@cols).each do |j|
        x = j * @resolution
        y = i * @resolution
        if @@universe.component(i, j) == 1
          draw_rect(x, y, @resolution - 1, @resolution - 1, Gosu::Color::WHITE, z = 1)
          draw_rect(x, y, 1, @resolution, Gosu::Color::BLACK, z = 1)
          draw_rect(x, y, @resolution, 1, Gosu::Color::BLACK, z = 1)
        end
      end
    end
  end

  def assign()
    @@new_universe.each_with_index do |v, i, j|
      @@universe.send(:[]=, i, j, v)
    end
  end
end

Game_of_life.new.show
