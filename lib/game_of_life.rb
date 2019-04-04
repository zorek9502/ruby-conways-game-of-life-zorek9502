require "gosu"
require_relative "rules"

class Game_of_life < Gosu::Window
  @width_screen
  @height_screen
  @resolution
  @@speed = 0.1

  def initialize
    @width_screen = 600
    @height_screen = 200
    @resolution = 10
    super @width_screen, @height_screen
    self.caption = "Game of life"
    @@rows = @height_screen / @resolution
    @@cols = @width_screen / @resolution
    @gol = GoL_Rules.new(@@rows, @@cols)
  end

  def update
    @gol.universe.each_with_index do |x, i, j|
      neighbors = @gol.count_neighbors(@gol.universe, i, j)
      new_cell_state = @gol.live_or_die(x, neighbors)
      @gol.new_universe.send(:[]=, i, j, new_cell_state)
    end
    assign()
    sleep @@speed
  end

  def draw
    (0...@@rows).each do |i|
      (0...@@cols).each do |j|
        x = j * @resolution
        y = i * @resolution
        if @gol.universe.component(i, j) == 1
          draw_rect(x, y, @resolution - 1, @resolution - 1, Gosu::Color::WHITE, z = 1)
          draw_rect(x, y, 1, @resolution, Gosu::Color::BLACK, z = 1)
          draw_rect(x, y, @resolution, 1, Gosu::Color::BLACK, z = 1)
        end
      end
    end
  end

  def assign()
    @gol.new_universe.each_with_index do |v, i, j|
      @gol.universe.send(:[]=, i, j, v)
    end
  end
end

Game_of_life.new.show
