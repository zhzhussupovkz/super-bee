=begin
/**
* @author zhzhussupovkz@gmail.com
* @copyright (c) 2014 Zhussupov Zhassulan zhzhussupovkz@gmail.com
*/
=end
#Bee - main player class
class Bee

  def initialize window
    @window, @x, @y = window, 600, 200
    begin
      @image = Gosu::Image.new window, 'images/player/bee.png', true
      @heart = Gosu::Image.new window, 'images/player/heart.png', true
      @cursor = Gosu::Image.new window, 'images/player/target.png', true
      @weapon = Weapon.new window, x - 5, y + 12
      @bomb = Bomb.new window, x - 10, y + 10
      @ui = Gosu::Font.new(window, 'Monospace', 25)
      @lives, @score, @stamina, @angle = 3, 0, 100, 0
      @green, @red = Gosu::Color.argb(0xff00ff00), Gosu::Color.argb(0xffff0000)
      @last_prize = Time.now.to_i
    rescue Exception => e
      puts "#{e.class}: #{e.message}"
    end
  end

  attr_reader :window, :x, :y, :score, :stamina, :green, :red, :angle
  attr_accessor :last_prize

  def draw
    @cursor.draw(window.mouse_x, window.mouse_y, 4)
    @image.draw_rot x, y, 3, angle
    @weapon.draw
    @bomb.draw
    window.draw_line(x - 10, y - 20, green, x - 10 + stamina/4, y - 20, green, 1, mode = :default)
    window.draw_line(x - 10 + stamina/4, y - 20, red, x + 15, y - 20, red, 1, mode = :default)
    @heart_x = 0
    @lives.times do
      @heart.draw(610 - @heart_x, 10, 5)
      @heart_x += 24
    end
    @ui.draw("Score: #{score}", 10, 10, 5)
  end

  def movement
    move_left if window.button_down? Gosu::KbA
    move_right if window.button_down? Gosu::KbD
    move_up if window.button_down? Gosu::KbW
    move_down if window.button_down? Gosu::KbS
    turn_left if window.button_down? Gosu::KbSpace
    turn_right
    bomber if window.button_down? Gosu::KbLeftControl
    @bomb.update
    @weapon.x, @weapon.y = x - 5, y + 12
    @weapon.shot if window.button_down? Gosu::MsLeft
    collect_nectar
    kill_enemies
    collect_prizes
  end

  def bomber
    @bomb.x, @bomb.y = x - 10, y + 2
    @bomb.drawing = true
  end

  #add injury when enemies attack
  def add_injury
    @stamina -= 4
    @x += 20.0
    @y += 15.0
    @x = 610 if @x >= 610
    @y = 425 if @y >= 425
    if @stamina <= 0
      @stamina = 0
      reboot
    end
  end

  #reboot player 
  def reboot
    sleep(2)
    @x, @y = 600, 200
    @lives -= 1
    @stamina = 100
  end

  def add_score_flowers
    @score += 100
  end

  def add_score_enemies
    @score += 250
  end

  def add_score_prizes
    @score += 50
  end

  #collecting nectar by player
  def collect_nectar
    window.world.flowers.each do |e|
      if x - e.x <= 32 && x - e.x >= 16 && (y - e.y).abs <= 15 && e.drawing
        e.nectar -= 5 if window.button_down? Gosu::KbSpace
      end
    end
  end

  #kill enemies by player
  def kill_enemies
    window.world.enemies.each do |e|
      if (Gosu::distance(window.mouse_x, window.mouse_y, e.x - 5.0, e.y) <= 10) && (window.button_down? Gosu::MsLeft) && e.drawing
        e.add_injury
      elsif (e.x - x).abs <= 15.0 && (e.y - y).abs <= 15.0 && e.drawing
        add_injury
      end
    end
  end

  #collect prizes
  def collect_prizes
    if (window.world.prize.x - @x).abs <= 15.0 && (window.world.prize.y - @y).abs <= 15.0 && (window.world.prize.drawing == true)
      window.world.prize.drawing = false
      @last_prize = Time.now.to_i
      add_score_prizes
    end
  end

  def move_left
    @x -= 7.0 if @x >= 25
  end

  def move_right
    @x += 7.0 if @x <= 610
  end

  def move_up
    @y -= 7.0 if @y >= 65
  end

  def move_down
    @y += 7.0 if @y <= 425
  end

  def turn_left
    @angle -= 20
    @angle = -45 if @angle <= -45
  end

  def turn_right
    @angle += 10 if @angle <= 0
  end
end
