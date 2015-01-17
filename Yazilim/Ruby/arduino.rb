require 'arduino_firmata'

class Arduino_Self

  @@arduino_uno = nil
  @@arduino_mega = nil
  @@arduino_mega2= nil

  @@bagli_uno = false
  @@bagli_mega = false
  @@bagli_mega2 = false

  def initialize uno_etkin, mega_etkin, mega2_etkin

    @uno_etkin = uno_etkin
    @mega_etkin = mega_etkin
    @mega2_etkin = mega2_etkin

    baglan
  end

  def f komut, deger, board

    ## Kart Tanimlama
    if board == 'uno'
      secili = @@bagli_uno
      secili_kart = @@arduino_uno
    elsif board == 'mega'
      secili = @@bagli_mega
      secili_kart = @@arduino_mega
    elsif board == 'mega2'
      secili = @@bagli_mega2
      secili_kart = @@arduino_mega2
    else
      secili = nil
      secili_kart = nil
      puts "HATA: Komutta (f) secilen kart taninmadi! (Kart: #{board}) (ErrorCode: 3)"
    end

    if secili == true # Secilen kart bagliysa

      if komut == 'led_yak'
        led_yak secili_kart
      end
      if komut == 'led_sondur'
        led_sondur secili_kart
      end

    else
      puts "HATA: Komutta belirtilen kart bagli degil! (Kart #{board}) (ErrorCode: 4)"
    end

  end

  private

  def led_yak kart
    kart.digital_write 12, 1
  end

  def led_sondur kart
    kart.digital_write 12, 0
  end

  def baglan
    print 'Bagli Arduino(lar) -> '
    @arduino_serial = Array(ArduinoFirmata.list)
    print "#@arduino_serial - Toplam: "
    pp @arduino_serial.length
    puts

    if @uno_etkin == false && @mega_etkin == false && @mega2_etkin == false
      puts '-> Hicbir Arduino Secilmedi'

    else

      if @arduino_serial.length > 0

        choose_board (@arduino_serial)

        if @uno_etkin and @boards['uno']
          puts "Arduino Uno'ya Baglaniliyor.."
          @@arduino_uno = ArduinoFirmata.connect @boards['uno'], :nonblock_io => true
          puts "Arduino Uno'ya Baglanildi"
          @@bagli_uno = true
        elsif @uno_etkin and !@boards['uno']
          puts 'HATA: Baglanilmak istenen kart bulunamadi! (Kart: Arduino Uno) (ErrorCode: 2)'
        end

        if @mega_etkin and @boards['mega']
          puts "Arduino Mega'ya Baglaniliyor.."
          @@arduino_mega = ArduinoFirmata.connect @boards['mega'], :nonblock_io => true
          puts "Arduino Mega'ya Baglanildi"
          @@bagli_mega = true
        elsif @mega_etkin and !@boards['mega']
          puts 'HATA: Baglanilmak istenen kart bulunamadi! (Kart: Arduino Mega) (ErrorCode: 2)'
        end

        if @mega2_etkin and @boards['mega2']
          puts "Arduino Mega 2'ye Baglaniliyor.."
          @@arduino_mega2 = ArduinoFirmata.connect @boards['mega2'], :nonblock_io => true
          puts "Arduino Mega 2'ye Baglanildi"
          @@bagli_mega2 = true
        elsif @mega2_etkin and !@boards['mega2']
          puts 'HATA: Baglanilmak istenen kart bulunamadi! (Kart: Arduino Mega2) (ErrorCode: 2)'
        end

      else
        puts 'HATA: Arduino Bulunamadi (ErrorCode: 1)'
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

      if i.match('USB1')
        print 'Mega 2 (Linux) -> '
        puts i
        if @mega2_etkin
          @boards = {'mega2' => i}
        end
      end

      if i.match('ACM')
        print 'Uno (Linux) -> '
        puts i
        if @uno_etkin
          @boards = {'uno' => i}
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
        print 'Uno (Mac) -> '
        puts i
        if @uno_etkin
          @boards = {'uno' => i}
        end
      end
    end
    puts
  end

  public
  def bagli_mi board
    if board == 'uno'
      @@bagli_uno
    elsif board == 'mega'
      @@bagli_mega
    elsif board == 'mega2'
      @@bagli_mega2
    else
      puts 'HATA: Bagli olup olmadigi sorulan kartin adi taninmadi! (ErrorCode: 6)'
    end
  end

  def close
    if @@bagli_uno
      @@arduino_uno.close
    elsif @@bagli_mega
      @@arduino_mega.close
    elsif @@bagli_mega2
      @@arduino_mega2.close
    end
  end

end