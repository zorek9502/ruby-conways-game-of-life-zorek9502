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
    create_universe(@@rows, @@cols)
  end

  #Metodo que crea los universos
  def create_universe(rows, cols)
    @universe = Matrix.build(rows, cols) { rand(2) } #Crea una matriz del tamaño espeficicado y la rellena con 1 y 0 de forma aleatoria
    @new_universe = Matrix.build(rows, cols) { } #Crea un segundo universo vacio
  end

  #Funcion para contar los vecinos vivos que tiene una celula en especifico, suma los 1
  def count_neighbors(universe, x, y)
    sum = 0
    (-1...2).each do |i|
      (-1...2).each do |j|
        eco_row = (x + i + @@rows) % @@rows
        eco_col = (y + j + @@cols) % @@cols
        sum += universe.component(eco_row, eco_col)
      end
    end
    sum -= universe.component(x, y) #Restamos la posicion de la celula de referencia, ya que ella no cuenta como vecino
  end

  #Reglas del juego que determinan si una celula vive o muere segun el numero de vecinos que esta tenga
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
