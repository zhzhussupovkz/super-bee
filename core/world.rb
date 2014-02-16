=begin
/**
* @author zhzhussupovkz@gmail.com
* @copyright (c) 2014 Zhussupov Zhassulan zhzhussupovkz@gmail.com
*/
=end
#World - main game logic class
class World

  def initialize window
    @window = window
    @bg = Gosu::Image.new window, 'images/world/background.png', true
    @green = Gosu::Image.new window, 'images/world/green.png', true
    @bee = Bee.new window
    @flowers, @enemies = [], []
    generate_flowers
    generate_enemies
  end

  attr_reader :window, :bee

  #generate all flowers
  def generate_flowers
    (50..600).step(75) do |i|
      @flowers << Flower.new(window, i, 425)
    end
  end

  #generate enemies - other bees
  def generate_enemies
    (20..450).step(50) do |i|
      y_cord = rand(75..425)
      @enemies << EnemyBee.new(window, i, y_cord)
    end
  end

  #draw
  def draw
    @bg.draw 0, 0, 0
    @green.draw 0, 440, 1
    @bee.draw
    @flowers.each do |f| f.draw end
    @enemies.each do |e| e.draw end
  end

  #update
  def update
    @bee.movement
    @flowers.each do |f| f.update end
    @enemies.each do |e| e.movement end
    collect_nectar
    kill_enemies
  end

  #collecting nectar by player
  def collect_nectar
    @flowers.each do |e|
      if bee.x - e.x <= 32 && bee.x - e.x >= 16 && (bee.y - e.y).abs <= 15 && e.drawing
        e.nectar -= 5 if window.button_down? Gosu::KbSpace
      end
    end
  end

  #kill enemies by player
  def kill_enemies
    @enemies.each do |e|
      if (Gosu::distance(window.mouse_x, window.mouse_y, e.x - 5.0, e.y) <= 10) && (window.button_down? Gosu::MsLeft) && e.drawing
        e.add_injury
      end
    end
  end

end
