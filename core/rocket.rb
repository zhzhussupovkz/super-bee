=begin
/**
* @author zhzhussupovkz@gmail.com
* @copyright (c) 2014 Zhussupov Zhassulan zhzhussupovkz@gmail.com
*/
=end
#Rocket - enemy's weapon class
class Rocket

  def initialize window, enemy, x, y
    begin
      @window = window
      @img = Gosu::Image.new window, "images/player/rocket.png", true
      @x, @y = x, y
      @fire = false
      @drawing = enemy.with_rocket
    rescue Exception => e
      puts "#{e.class}: #{e.message}"
    end
  end

  attr_reader :window
  attr_accessor :x, :y, :fire

  #draw
  def draw
    @img.draw @x, @y, 3 if @drawing
  end

  #shot
  def shot
    @x += 3 if @fire == true
    @fire = false if @x >= 640
  end

  #generate new rocket
  def change enemy
    @x, @y = enemy.x - 10, enemy.y + 10
    @fire = false
    enemy.last_rocket_attack = Time.now.to_i
  end

end
