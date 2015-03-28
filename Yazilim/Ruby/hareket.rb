$LOAD_PATH << '.'
require 'pin'
require 'bashself'

class Hareket


  def initialize board, gonder, motor
    @board = board
    @sensor = board.getSensor
    @motor = motor
    @gonder = gonder
    @bashself = BashSelf.new

    @thr_hareket = true
  end


  def start
    puts '==> Hareket Algilama Baslatildi <=='

    @board.ekran = 4


    # Otomatik Moddaysa Ses Çıkarma
    if @motor.get_otomatik != true
      @bashself.ses 'hareket_baslatildi'
    end
    

    @thread = Thread.new do
      while @thr_hareket
        hareket_kontrol
        sleep 0.1
      end
    end

    @ses_cal = true
    @ses_running = false
    @hareket_ilk = false

  end

  def stop
    puts '==> Hareket Algilama Sonlandirildi <=='
    @board.ekran = 5
    @thr_hareket = false
  end



  private

  def hareket_kontrol
    @sag = @sensor.hareket_sag.dup
    @sol = @sensor.hareket_sol.dup


    if @sag == 1 && @sol == 0
      @bashself.ses 'hareket_algilandi' if @ses_cal == true
      @bashself.kamera 'resim_cek'
      @gonder.servo 'sag'
      ses_kontrol
      @hareket_ilk = true if @hareket_ilk == false

    elsif @sag == 0 && @sol == 1
      @bashself.ses 'hareket_algilandi' if @ses_cal == true
      @bashself.kamera 'resim_cek'
      @gonder.servo 'sol'
      ses_kontrol
      @hareket_ilk = true if @hareket_ilk == false

    else
      @gonder.servo nil
    end

    sleep 0.1

  end


  # Sürekli hareket alglandı denmesini önler
  def ses_kontrol
    if @ses_running == false
      @ses_cal = false
      @ses_running = true

      Thread.new do
        s = Stopwatch.new
        @bir_kere = false

        loop do
          saat = s.elapsed_time
          if saat == 4 && @bir_kere == true
            @ses_cal = true
            @bir_kere = false
          end
          sleep 0.1
        end

      end
    end
  end


  # Sürekli çalışır, hareket olduğunda mail atar
  def mail_gonder
    Thread.new do
      loop do

        if @hareket_ilk == true
          sleep 2

          # TODO mail at

          # Bekle ve diğer resimleride at
          Thread.new do
            s = Stopwatch.new
            @bir_kere2 = true

            loop do
              saat = s.elapsed_time
              if saat == 10 && @bir_kere2 == true
                @bir_kere2 = false

                # TODO ikinci maili at
              end
              sleep 0.1
            end

          end

        end

        sleep 0.5
      end
    end
  end

  def getEtkin
    return @thr_hareket
  end


end




class Stopwatch

  def initialize()
    @start = Time.now
  end

  def elapsed_time
    now = Time.now
    elapsed = now - @start
    return elapsed.to_i
  end

end