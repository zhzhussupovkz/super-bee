=begin
/**
* @author zhzhussupovkz@gmail.com
* @copyright (c) 2014 Zhussupov Zhassulan zhzhussupovkz@gmail.com
*/
=end
class Bomb

  def initialize window, x, y
    @window, @x, @y = window, x, y
    @img = Gosu::Image.new window, 'images/player/bomb.png', true
    @drawing = false
  end

  attr_reader :window
  attr_accessor :drawing, :x, :y
  
  def draw
    @img.draw @x, @y, 3 if @drawing
  end

  def update
    move_down if @drawing
  end

  def move_down
    @y += 10 if @y <= 425
    @drawing = false if @y >= 425
  end
end