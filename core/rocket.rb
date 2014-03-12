=begin
/**
* @author zhzhussupovkz@gmail.com
* @copyright (c) 2014 Zhussupov Zhassulan zhzhussupovkz@gmail.com
*/
=end
#Rocket - enemy's weapon class
class Rocket

  def initialize window, x, y
    begin
      @window = window
      @img = Gosu::Image.new window, "images/player/rocket.png", true
      @x, @y = x, y
      @drawing = false
    rescue Exception => e
      puts "#{e.class}: #{e.message}"
    end
  end

  attr_reader :window
  attr_accessor :drawing, :x, :y

  #draw
  def draw
    @img.draw @x, @y, 3 if @drawing
  end

end
