=begin
/**
* @author zhzhussupovkz@gmail.com
* @copyright (c) 2014 Zhussupov Zhassulan zhzhussupovkz@gmail.com
*/
=end
#Flower
class Flower

  def initialize window, x, y
    @window, @x, @y = window, x, y
    @drawing, @nectar = true, 100
    begin
      img = ['blue_flower', 'red_flower', 'white_flower', 'pink_flower'].sample
      @image = Gosu::Image.new window, 'images/flowers/' + img +'.png', true
      @yellow, @gray = Gosu::Color.argb(0xffffff00), Gosu::Color.argb(0xff808080)
    rescue Exception => e
      puts "#{e.class}: #{e.message}"
    end
  end

  attr_reader :window, :x, :y, :nectar, :yellow, :gray

  def draw
    if @drawing
      @image.draw x, y, 2
      window.draw_line(x + 4, y - 3, yellow, x + 4 + nectar/4, y - 3, yellow, 1, mode = :default)
      window.draw_line(x + 4 + nectar/4, y - 3, gray, x + 29, y - 3, gray, 1, mode = :default)
    end
  end

  def update
    
  end

end
