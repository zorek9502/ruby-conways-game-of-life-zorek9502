require "Matrix"
#Rules
# 0 => 1 if 3 neighbors live
# 1 => 0 if less 2 live and than 3

class GoL_Rules
  attr_accessor :universe, :new_universe
  @@rows
  @@cols

  def initialize(width, height)
    @@rows = width
    @@cols = height
    create_universe(width, height)
  end

  def create_universe(rows, cols)
    @universe = Matrix.build(rows, cols) { rand(2) }
    @new_universe = Matrix.build(rows, cols) { }
    #@universe = Matrix[["a", "b", "c", "d"], ["e", "f", "g", "h"], ["i", "j", "k", "l"], ["m", "n", "o", "p"]]
  end

  #Funcion para contar los vecinos vivos
  def count_neighbors(universe, x, y)
    #puts "@@rows:#{@@rows}, @@cols:#{@@cols}"
    #puts "Estoy en #{x},#{y}, hay un #{universe.component(x, y)} "
    sum = 0
    (-1...2).each do |i|
      (-1...2).each do |j|
        eco_row = (x + i + @@rows) % @@rows
        eco_col = (y + j + @@cols) % @@cols
        #puts "Vecino: (#{i}, #{j}) de #{universe.component(x, y)} es: #{universe.component(eco_row, eco_col)}"
        sum += universe.component(eco_row, eco_col)
      end
    end
    #puts sum
    sum -= universe.component(x, y)
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
