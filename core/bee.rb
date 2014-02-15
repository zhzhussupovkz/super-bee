=begin
/**
* @author zhzhussupovkz@gmail.com
* @copyright (c) 2014 Zhussupov Zhassulan zhzhussupovkz@gmail.com
*/
=end
#Bee
class Bee

  def initialize window
    @window, @x, @y = window, 300, 200
    begin
      @image = Gosu::Image.new window, 'images/player/bee.png', true
      @heart = Gosu::Image.new window, 'images/player/heart.png', true
      @cursor = Gosu::Image.new window, 'images/player/target.png', true
      @weapon = Weapon.new window, x - 5, y + 12
      @bomb = Bomb.new window, x - 10, y + 10
      @ui = Gosu::Font.new(window, 'Monospace', 25)
      @lives, @score, @stamina, @angle = 3, 0, 100, 0
      @green, @red = Gosu::Color.argb(0xff00ff00), Gosu::Color.argb(0xffff0000)
    rescue Exception => e
      puts "#{e.class}: #{e.message}"
    end
  end

  attr_reader :window, :x, :y, :score, :stamina, :green, :red, :angle

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
  end

  def bomber
    @bomb.x, @bomb.y = x - 10, y + 2
    @bomb.drawing = true
  end

  def add_score
    @score += 100
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
