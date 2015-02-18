require 'arduino_firmata'
$LOAD_PATH << '.'
require 'hareket'
require 'log'

class Arduino_Self

  #LOG
  $konum = 'Arduino_Self'

  @@arduino_mega = nil
  @@arduino_mega2= nil

  @@bagli_mega = false
  @@bagli_mega2 = false

  def initialize mega_etkin, mega2_etkin

    $log = LOG.new

    @mega_etkin = mega_etkin
    @mega2_etkin = mega2_etkin

    baglan
  end




  def f komut, deger, board

    ## Kart Tanimlama
    if board == 'mega'
      secili = @@bagli_mega
      secili_kart = @@arduino_mega
    elsif board == 'mega2'
      secili = @@bagli_mega2
      secili_kart = @@arduino_mega2
    else
      secili = nil
      secili_kart = nil
      $log.hata $konum, "Komutta (f) secilen kart taninmadi! (Kart: #{board})"
    end


    # Secilen kart bagliysa
    if secili == true

      if komut == 'hareket_basla'
        #@hareket = Hareket.new secili_kart

        def hareket_kontrol
          pins = Pin.new

          @@arduino_mega.on :digital_read do |pin, status|
            puts '#{pin}, #{status}'
          end
        end


      elsif komut == 'hareket_durdur'
        @hareket.stop
      end

    else
      $log.hata $konum, "Komutta belirtilen kart bagli degil! (Kart: #{board}))"
    end

  end




  def pinMode array, choose_board

    @@tip = nil
    @@pin = nil
    @@aciklama = nil

    if @mega_etkin and @boards['mega'] and choose_board == 'mega'

      array.each do |a, b|

        a.each do |x,y|
          @@pin = x
          @@aciklama = y
        end

        if b == 1
          @@tip = ArduinoFirmata::OUTPUT
        elsif b == 2
          @@tip = ArduinoFirmata::INPUT
        elsif b == 3
          @@tip = ArduinoFirmata::SERVO
        end

        @@arduino_mega.pin_mode @@pin, @@tip

        #LOG
        $log.durum $konum, "pinMode -> Arduino Mega 1280 -> Pin=#{@@pin} -> Type=#{@@tip} OK"

      end

    else
      $log.hata $konum, '(PinMode:Error) PinMode Yapilamadi, Arduino Mega Bagli Degil'
    end

  end


  private

  def baglan
    print '==> Bagli Arduino(lar) -> '
    @arduino_serial = Array(ArduinoFirmata.list)
    print "#@arduino_serial - Toplam: "
    pp @arduino_serial.length
    puts

    if @mega_etkin == false && @mega2_etkin == false
      puts '-> '
      $log.durum $konum, 'Hicbir Arduino Secilmedi'

    else

      if @arduino_serial.length > 0

        choose_board (@arduino_serial)

        if @mega_etkin and @boards['mega']
          $log.islem_basladi $konum, "Arduino Mega'ya Baglaniliyor"
          @@arduino_mega = ArduinoFirmata.connect @boards['mega'], :nonblock_io => true
          $log.islem_bitti $konum, "Arduino Mega'ya Baglanildi"
          @@bagli_mega = true
        elsif @mega_etkin and !@boards['mega']
          puts 'HATA: Baglanilmak istenen kart bulunamadi! (Kart: Arduino Mega) (ErrorCode: 2)'
        end

        if @mega2_etkin and @boards['mega2']
          $log.islem_basladi $konum, "Arduino Mega 2'ye Baglaniliyor"
          @@arduino_mega2 = ArduinoFirmata.connect @boards['mega2'], :nonblock_io => true
          $log.islem_bitti $konum, "Arduino Mega 2'ye Baglanildi"
          @@bagli_mega2 = true
        elsif @mega2_etkin and !@boards['mega2']
          $log.hata $konum, 'Baglanilmak istenen kart bulunamadi! (Kart: Arduino Mega 2)'
        end

      else
        $log.hata $konum, 'Arduino Bulunamadi'
      end
    end
  end

  def choose_board array
    @boards = Hash.new

    array.each do |i|

      if i.match('USB0')
        print 'Mega (Linux) -> '
        puts i
        if @mega_etkin
          @boards = {'mega' => i}
        end
      end

      if i.match('ACM')
        print 'Mega 2 (Linux) -> '
        puts i
        if @mega2_etkin
          @boards = {'mega2' => i}
        end
      end

      if i.match('usbserial-A603JL3X')
        print 'Mega (Mac) -> '
        puts i
        if @mega_etkin
          @boards = {'mega' => i}
        end
      end

      if i.match('usbmodem')
        print 'Mega 2 (Mac) -> '
        puts i
        if @mega2_etkin
          @boards = {'mega2' => i}
        end
      end
    end
    puts
  end

  public
  def bagli_mi board
    if board == 'mega'
      @@bagli_mega
    elsif board == 'mega2'
      @@bagli_mega2
    else
      $log.hata $konum, 'Bagli olup olmadigi sorulan kartin adi taninmadi!'
    end
  end

  def close
    if @@bagli_mega
      @@arduino_mega.close
    elsif @@bagli_mega2
      @@arduino_mega2.close
    end
  end

end