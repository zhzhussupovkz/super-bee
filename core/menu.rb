=begin
/**
* @author zhzhussupovkz@gmail.com
* @copyright (c) 2014 Zhussupov Zhassulan zhzhussupovkz@gmail.com
*/
=end
#Menu
class Menu

  def initialize window
    begin
      @window, @display = window, true
      @bg = Gosu::Image.new window, 'images/world/background.png', true
      @cursor = Gosu::Image.new(@window, 'images/menu/cursor.png')
      @name = Gosu::Image.new(@window, 'images/menu/name.png')
      @icon = Gosu::Image.new(@window, 'images/menu/bee-menu.png')
      @new = Gosu::Image.new(window, 'images/menu/new.png', true)
      @controls = Gosu::Image.new(window, 'images/menu/controls.png', true)
      @exit = Gosu::Image.new(window, 'images/menu/exit.png', true)
      @weapon = Gosu::Image.new(window, 'images/menu/ak-menu.png', true)
      @c = Gosu::Font.new(window, 'Monospace', 20)
      @show_controls = false
    rescue Exception => e
      puts "#{e.class}: #{e.message}"
    end
  end

  attr_accessor :display

  def draw
    if @display === true
      @bg.draw(0,0,0)
      @name.draw(150, 25, 1)
      @icon.draw(275, 100, 1)
      @new.draw(300, 250, 1)
      @controls.draw(300, 300, 1)
      @exit.draw(300, 350, 1)
      @cursor.draw(@window.mouse_x, @window.mouse_y, 2)
      year = (Time.at(Time.now.to_i)).strftime("%Y")
      @c.draw("Copyright (c) #{year} by zhzhussupovkz", 200, 425, 1)
      @c.draw("Icons by http://findicons.com", 225, 450, 1)
      if 300 < @window.mouse_x &&
      @window.mouse_x < 396 &&
      250 < @window.mouse_y &&
      @window.mouse_y < 282
        @weapon.draw(400, 250, 1)
      elsif 300 < @window.mouse_x &&
      @window.mouse_x < 396 &&
      300 < @window.mouse_y &&
      @window.mouse_y < 332
        @weapon.draw(400, 300, 1)
      elsif 300 < @window.mouse_x &&
      @window.mouse_x < 396 &&
      350 < @window.mouse_y &&
      @window.mouse_y < 382
        @weapon.draw(400, 350, 1)
      end
      if @show_controls
        @c.draw("Movement: A,S,D,W", 100, 225, 1)
        @c.draw("Shot: Mouse Left", 100, 250, 1)
        @c.draw("Collect nectar: Space", 100, 275, 1)
        @c.draw("Bomb: Left Ctrl", 100, 300, 1)
        @c.draw("Pause: P", 100, 325, 1)
        @c.draw("Sound: Backspace", 100, 350, 1)
        @c.draw("Exit: Esc", 100, 375, 1)
      end
    end
  end

  #menu buttons logic
  def update
    if 300 < @window.mouse_x &&
    @window.mouse_x < 396 &&
    250 < @window.mouse_y &&
    @window.mouse_y < 282 && (@window.button_down? Gosu::MsLeft)
      new_game
    elsif 300 < @window.mouse_x &&
    @window.mouse_x < 396 &&
    300 < @window.mouse_y &&
    @window.mouse_y < 332 && (@window.button_down? Gosu::MsLeft)
      controls
    elsif 300 < @window.mouse_x &&
    @window.mouse_x < 396 &&
    350 < @window.mouse_y &&
    @window.mouse_y < 382 && (@window.button_down? Gosu::MsLeft)
      exit
    end
  end

  #new game button click event
  def new_game
    @display = false
    @window.pause = false
  end

  #show contorls
  def controls
    @show_controls = !@show_controls
  end

  #exit button click event
  def exit
    @window.pause = true
    @window.close
  end
  
end