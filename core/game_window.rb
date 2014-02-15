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
    rescue Exception => e
      puts "#{e.class}: #{e.message}"
    end
  end

  attr_reader :world

  #draw
  def draw
    @world.draw
  end

  #game logic
  def update
    @world.update
  end

  #button down event
  def button_down(key)
    case key
    when Gosu::KbEscape
      close
    end
  end
end