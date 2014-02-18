=begin
/**
* @author zhzhussupovkz@gmail.com
* @copyright (c) 2014 Zhussupov Zhassulan zhzhussupovkz@gmail.com
*/
=end
#Flower - flowers in level
class Flower

  def initialize window, x, y
    @window, @x, @y = window, x, y
    @drawing, @nectar = true, 100
    begin
      img = ['blue_flower', 'red_flower', 'white_flower', 'pink_flower'].sample
      @image = Gosu::Image.new window, 'images/flowers/' + img +'.png', true
      @yellow, @gray = Gosu::Color.argb(0xffffff00), Gosu::Color.argb(0xff808080)
      @last = Time.now.to_i
    rescue Exception => e
      puts "#{e.class}: #{e.message}"
    end
  end

  attr_reader :window, :x, :y, :yellow, :gray, :drawing
  attr_accessor :nectar

  def draw
    if @drawing
      @image.draw x, y, 2
      window.draw_line(x + 4, y - 3, yellow, x + 4 + nectar/4, y - 3, yellow, 1, mode = :default)
      window.draw_line(x + 4 + nectar/4, y - 3, gray, x + 29, y - 3, gray, 1, mode = :default)
    end
  end

  #update
  def update
    if @nectar == 0
      @nectar = 0
      @drawing = false
      @last = Time.now.to_i
      window.world.bee.add_score_flowers
      @nectar = 100
    elsif Time.now.to_i == @last + 5 && @drawing == false
      reboot
    end
  end

  #reboot flower when bee drink all nectar
  def reboot
    img = ['blue_flower', 'red_flower', 'white_flower', 'pink_flower'].sample
    @image = Gosu::Image.new window, 'images/flowers/' + img +'.png', true
    @drawing = true
  end

end
