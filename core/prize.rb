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
      @type = ['stamina', 'live', 'score'].sample
    rescue Exception => e
      puts "#{e.class}: #{e.message}"
    end
  end

  attr_accessor :drawing
  attr_reader :x, :y, :window, :type
  
  #draw
  def draw
    @img.draw(x, y, 3) if drawing
  end

  #moving
  def move
    @y += 1
    if @y >= 425
      @drawing = false
      @y = 0
      change
    end
  end

  #change to new prize
  def change
    @x, @y = rand(25..575), 50
    @type = ['stamina', 'live', 'score'].sample
    window.world.bee.last_prize = Time.now.to_i
  end

  #update
  def update
    move if @drawing
    curr = window.world.bee.last_prize
    time = rand(curr + 10..curr + 30)
    if time == Time.now.to_i
      @drawing = true
    end
  end

end