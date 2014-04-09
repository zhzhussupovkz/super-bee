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
      @last_shot, @fire = Time.now.to_i, true
    rescue Exception => e
      puts "#{e.class}: #{e.message}"
    end
  end

  attr_reader :window, :img
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
    if !window.world.bee.game_over?
      @img.draw_rot x, y, 3, angle
    else
      @img.draw_rot x, y, 3, 0
    end
  end

  #shot
  def shot
    if window.mouse_x + 50 < x && window.sound && window.world.bee.ammo > 0 && @fire == true
      window.world.bee.ammo -= 1
      @fire = false
      @last_shot = Time.now.to_i
      @sound.play(looping = false)
    end
  end

  #update
  def update
    if Time.now.to_i >= @last_shot + 1
      @fire = true
    end
  end

end
