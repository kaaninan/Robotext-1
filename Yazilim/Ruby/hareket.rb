$LOAD_PATH << '.'
require 'pin'

class Hareket


  def initialize board
    @board = board
    @sensor = board.getSensor
  end


  def start
    puts '==> Hareket Algilama Baslatildi <=='
    @thread = Thread.new do
      loop do
        hareket_kontrol
        sleep 0.01
      end
    end
  end

  def stop
    puts '==> Hareket Algilama Sonlandirildi <=='
    @thread.exit
  end



  private

  def hareket_kontrol
    @sag = @sensor.get_hareket_sag
    @sol = @sensor.get_hareket_sol

    if @sag == 1 && @sol == 0
      servo 'sag'
      sleep 1

    elsif @sag == 0 && @sol == 1
      servo 'sol'
      sleep 1

    else
      servo nil
    end
  end


end