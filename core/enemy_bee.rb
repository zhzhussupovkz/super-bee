=begin
/**
* @author zhzhussupovkz@gmail.com
* @copyright (c) 2014 Zhussupov Zhassulan zhzhussupovkz@gmail.com
*/
=end
#EnemyBee - player's enemies: other bees
class EnemyBee

  def initialize window, x, y
    @window, @x, @y = window, x, y
    @image = Gosu::Image.new window, 'images/player/bee-r.png', true
    @bombing = Gosu::Song.new(window, 'sounds/bomb.ogg')
    @stamina, @angle, @drawing = 100, 0, true
    @green, @red = Gosu::Color.argb(0xff00ff00), Gosu::Color.argb(0xffff0000)
  end

  attr_reader :window, :x, :y, :angle, :stamina, :green, :red
  attr_accessor :drawing
  
  def draw
    if @drawing
      @image.draw_rot x, y, 3, angle
      window.draw_line(x - 12, y - 20, green, x - 12 + stamina/4, y - 20, green, 1, mode = :default)
      window.draw_line(x - 12 + stamina/4, y - 20, red, x + 13, y - 20, red, 1, mode = :default)
    end
  end

  def movement
    move_right
    if stamina == 0
      @drawing = false
      window.world.bee.add_score_enemies
      @stamina = 100
    end
  end

  def move_right
    @x += 2.0
    reboot if @x >= 640
  end

  def reboot
    @x = 10
    @y = rand(75..425)
    @drawing = true
    @stamina = 100
  end

  #add injury when player attack
  def add_injury
    @stamina -= 10
    @stamina = 0 if @stamina <= 0
  end

  #add injury when player's bomb attack
  def add_injury_by_bomb
    @stamina = 0
    @bombing.play(looping = false)
  end
  
end
