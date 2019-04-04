require "gosu"
require_relative "rules"

#Clase grafica del jueg0
class Game_of_life < Gosu::Window
  @width_screen #Ancho ventana
  @height_screen #Alto ventana
  @resolution #Tamaño de las celulas
  @@speed = 0.1 #Velocidad del juego

  #Constructor en donde inicializamos todo lo necesario
  def initialize
    @width_screen = 600
    @height_screen = 200
    @resolution = 10
    super @width_screen, @height_screen
    self.caption = "Game of life"
    #Se determina el numero de filas y columnas en base a el alto/ancho de la ventana y el tamaño de la celula
    @@rows = @height_screen / @resolution
    @@cols = @width_screen / @resolution
    @gol = GoL_Rules.new(@@rows, @@cols)
  end

  #Actualiza el juego
  def update
    #Recorrer cada celula de nuestro universo
    @gol.universe.each_with_index do |x, i, j|
      neighbors = @gol.count_neighbors(@gol.universe, i, j) #Se cuentan cuantos vecinos tiene una celula en especifico (coordenadas)
      new_cell_state = @gol.live_or_die(x, neighbors) #En base a el numero de vecinos que tiene se determina si vive o muere
      @gol.new_universe.send(:[]=, i, j, new_cell_state) #Guardamos la nueva celula en el universo de la siguente generacion
    end
    assign() #Metodo para asignar la nueva generacion a la anterior y poder calcular la siguiente
    sleep @@speed #Se realentiza el programa para que muestre mejor los cambios de generacion
  end

  #Dibuja lo que requiere en la ventana
  def draw
    #Recorre las filas y las columnas calculando la nueva posicion donde se pintara un cuadro blanco si se detecta una celula viva
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

  #Metodo para asignar los valores de un universo a otro
  #Si se realiza con = reasigna la referencia del objeto, por eso se
  #recorre de uno en uno se se va asignando unicamente el valor
  def assign()
    @gol.new_universe.each_with_index do |v, i, j|
      @gol.universe.send(:[]=, i, j, v)
    end
  end
end

#Llama a ala clase y la muestra
Game_of_life.new.show
