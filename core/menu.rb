=begin
/**
* @author zhzhussupovkz@gmail.com
* @copyright (c) 2014 Zhussupov Zhassulan zhzhussupovkz@gmail.com
*/
=end
#Menu
class Menu

  def initialize window
    @window, @display = window, true
    @bg = Gosu::Image.new window, 'images/world/background.png', true
    @cursor = Gosu::Image.new(@window, 'images/menu/cursor.png')
    @c = Gosu::Font.new(window, 'Monospace', 20)
  end

  attr_accessor :display

  def draw
    if @display === true
      @bg.draw(0,0,0)
      @cursor.draw(@window.mouse_x, @window.mouse_y, 3)
      year = (Time.at(Time.now.to_i)).strftime("%Y")
      @c.draw("Copyright (c) #{year} by zhzhussupovkz", 275, 425, 2)
      @c.draw("Icons by http://findicons.com", 250, 450, 2)
    end
  end
  
end