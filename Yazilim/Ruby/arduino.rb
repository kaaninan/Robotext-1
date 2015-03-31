require 'rubygems'
require 'arduino_firmata'
require 'serialport'
require 'pp'
$LOAD_PATH << '.'
require 'log'
require 'sensor'
require 'pin'
require 'gonder'


class Arduino_Self

  #LOG
  $konum = 'Arduino_Self'

  @bagli_uno = false
  @bagli_mega = false

  
  # MEGA'YA GONDERILEN
  attr_accessor :deger_buzzer, :deger_ekran_isik, :deger_ekran, :deger_servo_x, :deger_servo_y, :deger_led_1, :deger_led_2

  
  def initialize
    $sensor = Sensor.new
    $log = LOG.new
    $pins = Pin.new

    baglan
    sleep 0.5

    pin_mode
    sleep 1

    uno_transistor true
    mega_serial
    mega_serial_gelen
    uno_sensor_oku

    mega_sensor_default

    @pin_1 = $pins.pin_ara 'led_1'
    @pin_2 = $pins.pin_ara 'led_2'

    @arduino_uno.digital_write @pin_1, 0
    @arduino_uno.digital_write @pin_2, 0

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
      # $log.islem_basladi $konum, "Arduino Uno'ya Baglaniliyor"
      @arduino_uno = ArduinoFirmata.connect @boards_uno, :nonblock_io => true
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

  def pin_mode

    #$log.islem_basladi $konum, 'PinMode'

    @tip = nil
    @pin = nil
    @aciklama = nil

    if @boards_uno

      array = $pins.getPins

      array.each do |a, b|

        a.each do |x,y|
          @pin = x
          @aciklama = y
        end

        if b == 1
          @tip = ArduinoFirmata::OUTPUT
        elsif b == 2
          @tip = ArduinoFirmata::INPUT
        elsif b == 3
          @tip = ArduinoFirmata::SERVO
        end

        @arduino_uno.pin_mode @pin, @tip

      end

    else
      $log.hata $konum, 'PinMode Yapilamadi, Arduino Uno Bagli Degil'
    end

    $log.islem_bitti $konum, 'PinMode'
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
        # @arduino_mega.write '-11&'
        # @arduino_mega.write '-12&'
        # @arduino_mega.write '-13&'
        # @arduino_mega.write '-14&'
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
          $sensor.hareket_sag = deger
        elsif komut == '-221'
          $sensor.hareket_sol = deger


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


  # THREAD
  def uno_sensor_oku
    Thread.new do
      loop do
        yakinlik_yer = $pins.pin_ara 'yakinlik_yer'
        motor_sag_on = $pins.pin_ara 'motor_sag_on_enkoder'
        motor_sag_arka = $pins.pin_ara 'motor_sag_arka_enkoder'
        motor_sol_on = $pins.pin_ara 'motor_sol_on_enkoder'
        motor_sol_arka = $pins.pin_ara 'motor_sol_arka_enkoder'

        $sensor.yakinlik_yer = @arduino_uno.analog_read yakinlik_yer
        $sensor.motor_sag_on_enkoder = @arduino_uno.analog_read motor_sag_on
        $sensor.motor_sag_arka_enkoder = @arduino_uno.analog_read motor_sag_arka
        $sensor.motor_sol_on_enkoder = @arduino_uno.analog_read motor_sol_on
        $sensor.motor_sol_arka_enkoder = @arduino_uno.analog_read motor_sol_arka

        sleep 0.1
      end
    end
  end


  def arduino_sms tur

    if tur == 'basla'

      @arduino_uno.digital_write @pin_1, 1
      @arduino_uno.digital_write @pin_2, 0

      sleep 2

      @arduino_uno.digital_write @pin_1, 0
      @arduino_uno.digital_write @pin_2, 0


    else
      @arduino_uno.digital_write @pin_1, 0
      @arduino_uno.digital_write @pin_2, 1

      sleep 2

      @arduino_uno.digital_write @pin_1, 0
      @arduino_uno.digital_write @pin_2, 0

    end

    @arduino_uno.digital_write @pin_1, 0
    @arduino_uno.digital_write @pin_2, 0


  end




  def mega_sensor_default
    @deger_buzzer = 0
    @deger_ekran_isik = 1
    @deger_ekran = 0
    @deger_servo_x = 80
    @deger_servo_y = 10
    @deger_led_1 = 1
    @deger_led_2 = 1
  end


  # SEND ARDUINO
  def uno_transistor gelen
    if gelen == true
      tr1 = $pins.pin_ara 'transistor_1'
      tr2 = $pins.pin_ara 'transistor_2'

      @arduino_uno.digital_write tr1, 1
      @arduino_uno.digital_write tr2, 1

    else
      tr1 = $pins.pin_ara 'transistor_1'
      tr2 = $pins.pin_ara 'transistor_2'

      @arduino_uno.digital_write tr1, 0
      @arduino_uno.digital_write tr2, 0
    end
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