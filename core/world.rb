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
    @prize = Prize.new window
    @flowers, @enemies = [], []
    generate_flowers
    generate_enemies
  end

  attr_reader :window, :bee, :prize, :flowers, :enemies

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
    @prize.draw
  end

  #update
  def update
    @bee.movement
    @flowers.each do |f| f.update end
    @enemies.each do |e| e.movement end
    @prize.update
  end

end
