$LOAD_PATH << '.'
require 'pin'
require 'bashself'

class Hareket


  def initialize board, gonder
    @board = board
    @sensor = board.getSensor
    @gonder = gonder
    @bashself = BashSelf.new
  end


  def start
    puts '==> Hareket Algilama Baslatildi <=='
    @bashself.ses 'hareket_baslatildi'
    @thread = Thread.new do
      loop do
        puts 'loop'
        hareket_kontrol
        sleep 0.1
      end
    end
  end

  def stop
    puts '==> Hareket Algilama Sonlandirildi <=='
    @thread.exit
    @gonder.servo_thread_exit
  end



  private

  def hareket_kontrol
    @sag = @sensor.get_hareket_sag
    @sol = @sensor.get_hareket_sol

    if @sag == 1 && @sol == 0
      @bashself.ses 'hareket_algilandi'
      @bashself.kamera 'resim_cek'
      @gonder.servo 'sag'
      sleep 1

    elsif @sag == 0 && @sol == 1
      @bashself.ses 'hareket_algilandi'
      @bashself.kamera 'resim_cek'
      @gonder.servo 'sol'
      sleep 1

    else
      @gonder.servo nil
    end
  end


end