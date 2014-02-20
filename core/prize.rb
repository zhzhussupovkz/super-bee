=begin
/**
* @author zhzhussupovkz@gmail.com
* @copyright (c) 2014 Zhussupov Zhassulan zhzhussupovkz@gmail.com
*/
=end
#Prize - prize for player when playing
class Prize

  def initialize window
    begin
      @window = window
      @x, @y, @drawing = rand(25..575), 50, false
      @img = Gosu::Image.new(window, "images/player/present.png", false)
    rescue Exception => e
      puts "#{e.class}: #{e.message}"
    end
  end

  attr_accessor :drawing
  attr_reader :x, :y
  
  #draw
  def draw
    @img.draw(x, y, 3) if drawing
  end

  #moving
  def move
    @y += 5
    if @y >= 425
      @drawing = false
      @y = 0
      change
    end
  end

  #change to new prize
  def change
    @x, @y = rand(25..575), 50
  end
  
end