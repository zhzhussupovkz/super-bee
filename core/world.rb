=begin
/**
* @author zhzhussupovkz@gmail.com
* @copyright (c) 2014 Zhussupov Zhassulan zhzhussupovkz@gmail.com
*/
=end
#World
class World

  def initialize window
    @window = window
    @bg = Gosu::Image.new window, 'images/world/background.png', true
    @green = Gosu::Image.new window, 'images/world/green.png', true
    @bee = Bee.new window
    @flowers = []
    generate_flowers
  end

  attr_reader :window, :bee

  def generate_flowers
    (50..600).step(75) do |i|
      @flowers << Flower.new(window, i, 425)
    end
  end
  
  def draw
    @bg.draw 0, 0, 0
    @green.draw 0, 440, 1
    @bee.draw
    @flowers.each do |f| f.draw end
  end

  def update
    @bee.movement
    @flowers.each do |f| f.update end
    collect_nectar
  end

  def collect_nectar
    @flowers.each do |e|
      if bee.x - e.x <= 32 && bee.x - e.x >= 16 && (bee.y - e.y).abs <= 15 && e.drawing
        e.nectar -= 5 if window.button_down? Gosu::KbSpace
      end
    end
  end
end