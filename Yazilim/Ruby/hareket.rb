$LOAD_PATH << '.'
require 'pin'
require 'bashself'
require 'mail'

class Hareket


  def initialize board, gonder, motor, bashself
    @board = board
    @sensor = board.getSensor
    @motor = motor
    @gonder = gonder
    @bashself = bashself
    @mail = MailSelf.new

    @thr_hareket = true
  end


  def start
    puts '==> Hareket Algilama Baslatildi <=='

    @board.deger_ekran = 5


    # Otomatik Moddaysa Ses Çıkarma
    if @motor.get_otomatik != true
      puts 'MAIL AT'
      @bashself.ses 'hareket_baslatildi'
    end

    @mail.mail 'hareket_baslatildi'
    

    @thread = Thread.new do
      while @thr_hareket
        hareket_kontrol
        sleep 0.1
      end
    end

    @ses_cal = true
    @ses_running = false

    # Mail Göndermek için
    @hareket_ilk = false

    # Üst üste hareket algılandi fonskiyonunu çalıştırmaması için
    @running_hareket_algilandi = false

  end


  def stop
    puts '==> Hareket Algilama Sonlandirildi <=='
    @board.deger_ekran = 6
    @thr_hareket = false
  end




  def hareket_kontrol
    @sag = @sensor.hareket_sag
    @sol = @sensor.hareket_sol

    if @sag == 1 && @sol == 0
      hareket_algilandi 'sag'

    elsif @sag == 0 && @sol == 1
      hareket_algilandi 'sol'

    else
      @gonder.servo nil
    end

    sleep 0.1

  end



  def hareket_algilandi yon

    # Eger fonksiyon calismiyorsa
    if @running_hareket_algilandi == false
      @running_hareket_algilandi = true

      # Ekrana Yazı Yaz
      Thread.new do
        @board.deger_ekran = 1
        sleep 4
        @board.deger_ekran = 5
      end

      # Ses Çal
      if @ses_cal == true
        @bashself.ses 'hareket_algilandi'
        puts 'SES CAL'
      end

      # Harekete Don
      if yon == 'sag'
        @gonder.servo 'sag'
      else
        @gonder.servo 'sol'
      end

      @board.uno_sms 2

      # Resim Cek
      # @bashself.kamera 'resim_cek'
      Thread.new do
        sleep 4
        `$HOME/kamera.sh`
      end

      # Sesin Sürekli Cıkmaması İçin
      # ses_kontrol

      # Mail At

      @hareket_ilk = true if @hareket_ilk == false

      sleep 6
      @mail.mail 'hareket_algilandi'
      @running_hareket_algilandi = false

    end

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