=begin
/**
* @author zhzhussupovkz@gmail.com
* @copyright (c) 2014 Zhussupov Zhassulan zhzhussupovkz@gmail.com
*/
=end
#EnemyBee - player's enemies: other bees
class EnemyBee

  def initialize window, x, y
    begin
      @window, @x, @y = window, x, y
      @image = Gosu::Image.new window, 'images/player/bee-r.png', true
      @bombing = Gosu::Song.new(window, 'sounds/bomb.ogg')
      @stamina, @angle, @drawing = 100, 0, true
      @green, @red = Gosu::Color.argb(0xff00ff00), Gosu::Color.argb(0xffff0000)
      @last_rocket_attack, @with_rocket = Time.now.to_i, [true, false].sample
      @rocket = Rocket.new window, self, x - 10, y + 10
    rescue Exception => e
      puts "#{e.class}: #{e.message}"
    end
  end

  attr_reader :window, :x, :y, :angle, :stamina, :green, :red, :rocket
  attr_accessor :drawing, :last_rocket_attack, :with_rocket

  def draw
    @rocket.draw if @rocket.fire == true
    if @drawing
      @image.draw_rot x, y, 3, angle
      window.draw_line(x - 12, y - 20, green, x - 12 + stamina/4, y - 20, green, 1, mode = :default)
      window.draw_line(x - 12 + stamina/4, y - 20, red, x + 13, y - 20, red, 1, mode = :default)
    end
  end

  def movement
    move_right
    rocket_attack
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
    @with_rocket = [true, false].sample
  end

  #add injury when player attack
  def add_injury
    @stamina -= 10
    @stamina = 0 if @stamina <= 0
  end

  #add injury when player's bomb attack
  def add_injury_by_bomb
    @stamina = 0
    @bombing.play(looping = false) if window.sound
  end

  #rocket attack
  def rocket_attack
    @rocket.x, @rocket.y = x - 10, y + 10 if @rocket.fire == false
    curr = @last_rocket_attack
    time = rand(curr + 3..curr + 5)
    if time == Time.now.to_i
      @rocket.fire = true
    end
    @rocket.shot
    @rocket.change self if @rocket.x >= 640
  end
  
end
