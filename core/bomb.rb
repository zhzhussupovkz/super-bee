=begin
/**
* @author zhzhussupovkz@gmail.com
* @copyright (c) 2014 Zhussupov Zhassulan zhzhussupovkz@gmail.com
*/
=end
#Bomb - player's additional weapon class
class Bomb

  def initialize window, x, y
    @window, @x, @y = window, x, y
    @img = Gosu::Image.new window, 'images/player/bomb.png', true
    @drawing = false
  end

  attr_reader :window
  attr_accessor :drawing, :x, :y
  
  #draw
  def draw
    @img.draw @x, @y, 3 if @drawing
  end

  #update
  def update
    if @drawing
      move_down
      kill_enemies
    end
  end

  #move down when player bomb
  def move_down
    @y += 7 if @y <= 425
    @drawing = false if @y >= 425
  end

  #kill enemies by player's bomb
  def kill_enemies
    window.world.enemies.each do |e|
      if (Gosu::distance(x, y, e.x - 10, e.y + 5) <= 15) && e.drawing
        e.add_injury_by_bomb
        @drawing = false
      end
    end
  end
end
