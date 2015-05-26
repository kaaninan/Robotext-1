$LOAD_PATH << '.'
require 'pin'
require 'bashself'
require 'mail'

class Hareket


  def initialize board, motor, var
    $var = var
    @board = board
    @motor = motor
    @bashself = BashSelf.new
    @mail = MailSelf.new
    @thr_hareket = true
  end


  def start
    puts '==> Hareket Algilama Baslatildi <=='

    $var.m_ekran = 5

    # @mail.mail 'hareket_baslatildi'
    
    @thread = Thread.new do
      while @thr_hareket
        hareket_kontrol
        sleep 0.1
      end
    end

    # @ses_cal = true
    # @ses_running = false

    # Mail Göndermek için
    @hareket_ilk = false

    # Üst üste hareket algılandi fonskiyonunu çalıştırmaması için
    @running_hareket_algilandi = false

  end


  def stop
    puts '==> Hareket Algilama Sonlandirildi <=='
    $var.m_ekran = 6
    @thr_hareket = false
    $var.servo nil
  end




  def hareket_kontrol
    @sag = $var.hareket_sag
    @sol = $var.hareket_sol

    if @sag == 1 && @sol == 0
      hareket_algilandi 'sag'

    elsif @sag == 0 && @sol == 1
      hareket_algilandi 'sol'

    else
      $var.servo nil
    end

    sleep 0.1

  end



  def hareket_algilandi yon

    # Eger fonksiyon calismiyorsa
    if @running_hareket_algilandi == false
      @running_hareket_algilandi = true

      # Ekrana Yazı Yaz
      Thread.new do
        $var.m_ekran = 1
        sleep 4
        $var.m_ekran = 5
      end

      # Ses Çal
      $var.buzzer 4

      # Harekete Don
      if yon == 'sag'
        $var.servo 'sag'
      else
        $var.servo 'sol'
      end

      # Sms At
      # @board.uno_sms 2

      # Resim Cek
      Thread.new do
        sleep 0.5
        `$HOME/kamera.sh`
      end

      # Sesin Sürekli Cıkmaması İçin
      # ses_kontrol

      # Mail At
      @hareket_ilk = true if @hareket_ilk == false

      sleep 6
      # $var.mailAt = true
      @mail.mail 'hareket_algilandi'
      $var.servo nil
      sleep 1000
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



  def gonderMail

    @bashself.kamera 'resim_bul'

    sleep 3

    @array = @bashself.get_resim_listesi


    puts 'Hareket Maili Gonderiliyor..'

    @sayi = @array.length

    @isim = @array[@sayi-1]

    puts
    puts @isim
    puts


    Pony.mail({
                  :to => 'kaaninan@outlook.com',
                  :subject => 'ROBOTEXT',
                  :attachments => {"resim1.jpg" => File.read(@isim), "logo.png" => File.read("mail/logo.png")},
                  :html_body => File.read("/home/pi/Robotext/Yazilim/Ruby/mail/hareket_algilandi.htm"),
                  :sender => 'Robotext',
                  :via => :smtp,
                  :via_options => {
                      :address        => 'smtp.gmail.com',
                      :port           => '587',
                      :user_name      => 'robotext.afl',
                      :password       => 'raspberry_12',
                      :authentication => :login, # :plain, :login, :cram_md5, no auth by default
                      :domain         => "Robotext" # the HELO domain provided by the client to the server
                  }
              })

    puts 'Gonderildi ..'

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