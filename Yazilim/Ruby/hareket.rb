$LOAD_PATH << '.'
require 'pin'

class Hareket


  def initialize board

    @board = board

    puts '==> Hareket Algilama Baslatildi <=='

    thread = Thread.new do
      hareket_kontrol
    end

  end


  def hareket_kontrol
    pins = Pin.new

    @board.on :digital_read do |pin, status|
      if pin == pins.pin_ara('hareket_on_sol')
        puts status
      end
    end
  end


  def stop
  end

end