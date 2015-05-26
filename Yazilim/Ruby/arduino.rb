require 'rubygems'
require 'serialport'
require 'pp'
require 'arduino_firmata'
$LOAD_PATH << '.'
require 'log'
require 'pin'

# Toplam 2 Kart; Arduino Uno, Arduino Mega
# Otomatik Kart Tanımlama

# - Arduino'lara bağlan
# - Serial'den bilgi alışverişi yap
# without Firmata



class Arduino_Self

  $konum = 'Arduino_Self'

  # Gonderilecek Degerler
  attr_accessor :motor_komut

  
  def initialize var
    $log = LOG.new
    $var = var

    $var.bagli_uno = false
    $var.bagli_mega = false
    
    baglan

    if $var.bagli_uno
      uno_serial
    end

    if $var.bagli_mega
      mega_serial
      mega_serial_gelen
    end

    sensor_default

  end

  private

  def baglan
    print '==> Bagli Arduino(lar) -> '
    @arduino_serial = Array(ArduinoFirmata.list)
    print "#@arduino_serial - Toplam: "
    pp @arduino_serial.length
    puts
    choose_board (@arduino_serial)

    if @boards_uno
      @arduino_uno = SerialPort.new(@boards_uno, 115200, 8, 1, SerialPort::NONE)
      $log.islem_bitti $konum, "Arduino Uno'ya Baglanildi"
      $var.bagli_uno = true
    elsif !@boards_uno
      $var.bagli_uno = false
      $log.hata $konum, 'Baglanilmak istenen kart bulunamadi! (Kart: Arduino Uno)'
    end
    if @boards_mega
      @arduino_mega = SerialPort.new(@boards_mega, 115200, 8, 1, SerialPort::NONE)
      $log.islem_bitti $konum, "Arduino Mega'ya Baglanildi"
      $var.bagli_mega = true
    elsif !@boards_mega
      $var.bagli_mega = false
      $log.hata $konum, 'Baglanilmak istenen kart bulunamadi! (Kart: Arduino Mega)'
    end
  end

  def choose_board array
    @boards_uno
    @boards_mega

    array.each do |i|

      if i.match('ACM')
        print 'Uno (Linux) -> '
        puts i
        @boards_uno = i

      elsif i.match('USB')
        print 'Mega (Linux) -> '
        puts i
        @boards_mega = i

      elsif i.match('usbmodem')
        print 'Uno (Mac) -> '
        puts i
        @boards_uno = i

      elsif i.match('usbserial')
        print 'Mega (Mac) -> '
        puts i
        @boards_mega = i
      end
    end
    puts
  end



  public


  # THREAD
  def mega_serial

    Thread.new do

      loop do

        ## KOMUT GONDER
        @arduino_mega.write "+1 #{$var.m_buzzer}&" # Buzzer
        @arduino_mega.write "+2 #{$var.m_ekran_isik}&" # Ekran Isik
        @arduino_mega.write "+3 #{$var.m_ekran}&" # Ekran
        @arduino_mega.write "+4 #{$var.m_servox}&" # Servo X
        @arduino_mega.write "+5 #{$var.m_servoy}&" # Servo Y

        ## VERI ISTE
        @arduino_mega.write '-21&'
        @arduino_mega.write '-22&'
        @arduino_mega.write '-3&'
        @arduino_mega.write '-4&'
        @arduino_mega.write '-5&'
        @arduino_mega.write '-6&'
        @arduino_mega.write '-71&'
        @arduino_mega.write '-72&'

        sleep 0.05

      end
    end
  end


  # THREAD
  def mega_serial_gelen
    Thread.new do
      while (i = @arduino_mega.gets.chomp) do

        # puts "Mega'dan Gelen:  #{i}"

        gelen = i.split ' ', 2

        komut = gelen[0]
        deger = gelen[1].to_i

        if komut == '-211'
          $var.hareket_sol = deger
        elsif komut == '-221'
          $var.hareket_sag = deger


        elsif komut == '-31'
          $var.ses = deger

        elsif komut == '-41'
          $var.isik = deger

        elsif komut == '-51'
          $var.sicaklik = deger

        elsif komut == '-61'
          $var.gaz = deger

        elsif komut == '-711'
          $var.uzaklik_on_sag = deger
        elsif komut == '-721'
          $var.uzaklik_on_sol = deger

        end
      end
    end
  end


  # THREAD
  def uno_serial

    Thread.new do

      loop do

        if motor_komut == 'ileri'
          @arduino_uno.write "+1&"
          @arduino_uno.write "+5 175&"
          @arduino_uno.write "+6 175&"

        elsif motor_komut == 'dur'
          @arduino_uno.write "+10&"

        elsif motor_komut == 'geri'
          @arduino_uno.write "+2&"
          @arduino_uno.write "+5 175&"
          @arduino_uno.write "+6 175&"

        elsif motor_komut == 'sag'
          @arduino_uno.write "+3&"
          @arduino_uno.write "+5 175&"
          @arduino_uno.write "+6 0&"

        elsif motor_komut == 'sol'
          @arduino_uno.write "+4&"
          @arduino_uno.write "+5 0&"
          @arduino_uno.write "+6 175&"

        elsif motor_komut == 'yavas'
          @arduino_uno.write "+1&"
          @arduino_uno.write "+5 90&"
          @arduino_uno.write "+6 90&"
        end

        sleep 0.01

      end

    end

  end


  def uno_sms secenek

    Thread.new do

      if secenek == 1
        @arduino_uno.write "+7&"
        sleep 0.1
      elsif secenek == 2
        @arduino_uno.write "+8&"
        sleep 0.1
      elsif secenek == 3
        @arduino_uno.write "+9&"
        sleep 0.1
      end

    end

  end




  def sensor_default
    $var.m_buzzer = 0
    $var.m_ekran_isik = 1
    $var.m_ekran = 0
    $var.m_servox = 80
    $var.m_servoy = 100
    @motor_komut = 'dur'
  end




  # GETTER

  def getUno
    return @arduino_uno
  end

  def getMega
    return @arduino_mega
  end


  def close
    @arduino_uno.close
  end

end