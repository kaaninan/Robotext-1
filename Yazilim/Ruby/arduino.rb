require 'rubygems'
require 'arduino_firmata'
require 'serialport'
require 'pp'
$LOAD_PATH << '.'
require 'log'
require 'sensor'
require 'pin'
require 'gonder'

# Toplam 2 Kart; Arduino Uno, Arduino Mega
# Otomatik Kart Tanımlama

# - Arduino'lara bağlan
# - Serial'den bilgi alışverişi yap
# with Firmata



class Arduino_Self

  $konum = 'Arduino_Self'

  @bagli_uno = false
  @bagli_mega = false


  # Gonderilecek Degerler
  attr_accessor :deger_buzzer, :deger_ekran_isik, :deger_ekran, :deger_servo_x, :deger_servo_y, :deger_led_1, :deger_led_2, :motor_komut

  
  def initialize
    $sensor = Sensor.new
    $log = LOG.new

    baglan
    sleep 0.5

    uno_serial
    mega_serial
    mega_serial_gelen

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
      @bagli_uno = true
    elsif !@boards_uno
      $log.hata $konum, 'Baglanilmak istenen kart bulunamadi! (Kart: Arduino Uno)'
    end


    if @boards_mega
      # $log.islem_basladi $konum, "Arduino Mega'ya Baglaniliyor"
      @arduino_mega = SerialPort.new(@boards_mega, 115200, 8, 1, SerialPort::NONE)
      $log.islem_bitti $konum, "Arduino Mega'ya Baglanildi"
      @bagli_mega = true
    elsif !@boards_mega
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
        @arduino_mega.write "+1 #{@deger_buzzer}&" # Buzzer
        @arduino_mega.write "+2 #{@deger_ekran_isik}&" # Ekran Isik
        @arduino_mega.write "+3 #{@deger_ekran}&" # Ekran
        @arduino_mega.write "+4 #{@deger_servo_x}&" # Servo X
        @arduino_mega.write "+5 #{@deger_servo_y}&" # Servo Y
        @arduino_mega.write "+6 #{@deger_led_1}&" # Led 1
        @arduino_mega.write "+7 #{@deger_led_2}&" # Led 2


        ## VERI ISTE
        @arduino_mega.write '-21&'
        sleep 0.01
        @arduino_mega.write '-22&'
        sleep 0.01
        @arduino_mega.write '-3&'
        sleep 0.01
        @arduino_mega.write '-4&'
        sleep 0.01
        @arduino_mega.write '-5&'
        sleep 0.01
        @arduino_mega.write '-6&'
        sleep 0.01
        @arduino_mega.write '-71&'
        sleep 0.01
        @arduino_mega.write '-72&'
        sleep 0.01

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

        if komut == '-111'
          $sensor.uzaklik_on = deger
        elsif komut == '-121'
          $sensor.uzaklik_sol = deger
        elsif komut == '-131'
          $sensor.uzaklik_sag = deger
        elsif komut == '-141'
          $sensor.uzaklik_arka = deger


        elsif komut == '-211'
          $sensor.hareket_sol = deger
        elsif komut == '-221'
          $sensor.hareket_sag = deger


        elsif komut == '-31'
          $sensor.ses = deger

        elsif komut == '-41'
          $sensor.isik = deger

        elsif komut == '-51'
          $sensor.sicaklik = deger

        elsif komut == '-61'
          $sensor.gaz = deger

        elsif komut == '-711'
          $sensor.uzaklik_on_sag = deger
        elsif komut == '-721'
          $sensor.uzaklik_on_sol = deger

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
          @arduino_uno.write "+5&"

        elsif motor_komut == 'dur'
          @arduino_uno.write "+6&"

        elsif motor_komut == 'geri'
          @arduino_uno.write "+2&"
          @arduino_uno.write "+5&"

        elsif motor_komut == 'sag'
          @arduino_uno.write "+3&"
          @arduino_uno.write "+5&"

        elsif motor_komut == 'sol'
          @arduino_uno.write "+4&"
          @arduino_uno.write "+5&"
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
      else
        @arduino_uno.write "+8&"
        sleep 0.1
      end

    end

  end




  def sensor_default
    @deger_buzzer = 0
    @deger_ekran_isik = 1
    @deger_ekran = 0
    @deger_servo_x = 80
    @deger_servo_y = 100
    @deger_led_1 = 1
    @deger_led_2 = 1
    @motor_komut = 'dur'
  end




  # GETTER
  def getSensor
    return $sensor
  end

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