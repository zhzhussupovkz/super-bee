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
    @snd_on = Gosu::Image.new window, 'images/world/snd_on.png', true
    @snd_off = Gosu::Image.new window, 'images/world/snd_off.png', true
    @ui = Gosu::Font.new(window, 'Monospace', 20)
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
      y_cord = rand(95..425)
      @enemies << EnemyBee.new(window, i, y_cord)
    end
  end

  #draw
  def draw
    @bg.draw 0, 0, 0
    @green.draw 0, 440, 1
    if window.sound
      @snd_on.draw 535, 10, 1
    else
      @snd_off.draw 535, 10, 1
    end
    @bee.draw
    @flowers.each do |f| f.draw end
    @enemies.each do |e| e.draw end
    @prize.draw
    year = (Time.at(Time.now.to_i)).strftime("%Y")
    @ui.draw("Copyright (c) #{year} by zhzhussupovkz", 175, 460, 4)
  end

  #update
  def update
    @bee.movement
    if !@bee.game_over?
      @flowers.each do |f| f.update end
      @enemies.each do |e| e.movement end
      @prize.update
    end
  end

end
