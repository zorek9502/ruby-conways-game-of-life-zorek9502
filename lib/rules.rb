require "Matrix"
#Rules
# 0 => 1 if 3 neighbors live
# 1 => 0 if less 2 live and than 3

class GoL_Rules
  def initialize
    #attr_accessor @width, @height
    @universe
    #create_universe(@width, @height)
  end

  def create_universe(cols, rows)
    @universe = Matrix.build(row, cols) { rand(2) }
    #@universe = Matrix[["a", "b", "c", "d"], ["e", "f", "g", "h"], ["i", "j", "k", "l"], ["m", "n", "o", "p"]]
  end

  #Funcion para contar los vecinos vivos
  def count_neighbors(universe, i, j)
    sum = 0
    (-1...2).each do |x|
      (-1...2).each do |y|
        sum += universe.component(x, y)
      end
    end
    sum -= universe.component(i, j)
  end

  def live_or_die(cell, neighbors)
    if cell == 0 and neighbors == 3
      return 1
    elsif (cell == 1 and (neighbors < 2 || neighbors > 3))
      return 0
    else
      return cell
    end
  end
end
