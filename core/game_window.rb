=begin
/**
* @author zhzhussupovkz@gmail.com
* @copyright (c) 2014 Zhussupov Zhassulan zhzhussupovkz@gmail.com
*/
=end
#GameWindow - main window class
class GameWindow < Gosu::Window

  include Singleton

  def initialize
    super 640, 480, false
    self.caption = 'Super Bee'
    begin
      @world = World.new self
      @menu = Menu.new self
      @pause = true
    rescue Exception => e
      puts "#{e.class}: #{e.message}"
    end
  end

  attr_reader :world
  attr_accessor :pause

  #draw
  def draw
    @menu.draw
    @world.draw if @menu.display === false
  end

  #game logic
  def update
    @menu.update if pause
    @world.update if not pause
  end

  #button down event
  def button_down(key)
    case key
    when Gosu::KbEscape
      close
    when Gosu::KbP
      @pause = !@pause if @menu.display === false
    end
  end
end
