=begin
/**
* @author zhzhussupovkz@gmail.com
* @copyright (c) 2014 Zhussupov Zhassulan zhzhussupovkz@gmail.com
*/
=end
#Weapon - player's main weapon class
class Weapon

  def initialize window, x, y
    begin
      @window = window
      @img = Gosu::Image.new window, "images/player/ak.png", true
      @x, @y, @angle = x, y, 0
      @sound = Gosu::Song.new window, 'sounds/ak.ogg'
    rescue Exception => e
      puts "#{e.class}: #{e.message}"
    end
  end

  attr_reader :window
  attr_accessor :x, :y

  #calculate angle
  def angle
    if window.mouse_x > x - 50 && window.mouse_y > y + 50
      @angle = -45
    elsif window.mouse_x > x - 50 && window.mouse_y < y - 50
      @angle = 30
    elsif window.mouse_x > x + 5
      @angle = 0
    else
      @angle = Gosu::angle(window.mouse_x, window.mouse_y, x, y) - 100
    end
  end

  #draw
  def draw
    @img.draw_rot x, y, 3, angle
  end

  #shot
  def shot
    @sound.play(looping = false) if window.mouse_x + 50 < x
  end

end