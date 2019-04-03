require_relative "rules"
rows = 4
cols = 4
#gol = GoL_Rules.new(rows, cols)
puts "Hola"

def evaluate_gen(gol, universe, new_universe)
  puts universe
  universe.each_with_index do |x, i, j|
    neighbors = gol.count_neighbors(universe, i, j)
    new_cell_state = gol.live_or_die(x, neighbors)
    puts "la celula #{x} tiene #{neighbors} por lo tanto va a #{new_cell_state}"
    new_universe.send(:[]=, i, j, new_cell_state)
  end
  puts new_universe
  new_universe
end

#evaluate_gen(gol, universe, new_universe)
#gol.new_universe = gol.universe
