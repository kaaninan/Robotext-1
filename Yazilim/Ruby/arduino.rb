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


  def initialize
    $sensor = Sensor.new
    $log = LOG.new
    @pins = Pin.new

    baglan
    sleep 1

    pinMode 'uno'
    sleep 0.1

    # Transistor Aç
    uno_transistor true


    # Mega Serial Oku
    mega_serial_gelen

    uno_sensor_oku        

  end

  def setGonder gonder
    # Daha sonradan set edilecek
    @gonder = gonder
    
    # Mega Veri Iste
    @gonder.gonder_mega
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
      $log.islem_basladi $konum, "Arduino Uno'ya Baglaniliyor"
      @arduino_uno = ArduinoFirmata.connect @boards_uno, :nonblock_io => true
      $log.islem_bitti $konum, "Arduino Uno'ya Baglanildi"
      @bagli_uno = true
    elsif !@boards_uno
      $log.hata $konum, 'Baglanilmak istenen kart bulunamadi! (Kart: Arduino Uno)'
    end


    if @boards_mega
      $log.islem_basladi $konum, "Arduino Mega'ya Baglaniliyor"
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

  def pinMode choose_board

    $log.islem_basladi $konum, 'PinMode'

    @tip = nil
    @pin = nil
    @aciklama = nil

    if @boards_uno and choose_board == 'uno'

      pin = Pin.new
      array = pin.getPins

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

  # NO LOOP
  def mega_serial_gonder komut, deger

    if komut == 'buzzer'
      @arduino_mega.write "+1 #{deger}&"

    elsif komut == 'ekran_isik'
      @arduino_mega.write "+2 #{deger}&"

    elsif komut == 'ekran'
      @arduino_mega.write "+3 #{deger}&"

    elsif komut == 'servo_x'
      @arduino_mega.write "+4 #{deger}&"

    elsif komut == 'servo_y'
      @arduino_mega.write "+5 #{deger}&"

    elsif komut == 'led_1'
      @arduino_mega.write "+6 #{deger}&"

    elsif komut == 'led_2'
      @arduino_mega.write "+7 #{deger}&"




    elsif komut == 'uzaklik'
      @arduino_mega.write '-11 &'
      @arduino_mega.write '-12 &'
      @arduino_mega.write '-13 &'
      @arduino_mega.write '-14 &'
      @arduino_mega.write '-15 &'
      @arduino_mega.write '-16 &'

    elsif komut == 'hareket'
      @arduino_mega.write '-21&'
      @arduino_mega.write '-22&'

    elsif komut == 'ses'
      @arduino_mega.write '-3&'

    elsif komut == 'isik'
      @arduino_mega.write '-4&'

    elsif komut == 'yakinlik'
      @arduino_mega.write '-51&'
      @arduino_mega.write '-52&'


    elsif komut == 'sicaklik'
      @arduino_mega.write '-6&'


    elsif komut == 'sensorler'
      @arduino_mega.write '-11&'
      @arduino_mega.write '-12&'
      @arduino_mega.write '-13&'
      @arduino_mega.write '-14&'
      @arduino_mega.write '-15&'
      @arduino_mega.write '-16&'
      @arduino_mega.write '-21&'
      @arduino_mega.write '-22&'
      @arduino_mega.write '-3&'
      @arduino_mega.write '-4&'
      @arduino_mega.write '-51&'
      @arduino_mega.write '-52&'
      @arduino_mega.write '-6&'
    end
  end


  # THREAD WHILE
  def mega_serial_gelen
    Thread.new do
      while (i = @arduino_mega.gets.chomp) do

        # puts "Mega'dan Gelen:  #{i}"

        gelen = i.split ' ', 2

        komut = gelen[0]
        deger = gelen[1]

        if komut == '-111'
          $sensor.uzaklik_on_sag = deger
        elsif komut == '-121'
          $sensor.uzaklik_on_sol = deger
        elsif komut == '-131'
          $sensor.uzaklik_sag_on = deger
        elsif komut == '-141'
          $sensor.uzaklik_sag_arka = deger
        elsif komut == '-151'
          $sensor.uzaklik_sol_on = deger
        elsif komut == '-161'
          $sensor.uzaklik_sol_arka = deger


        elsif komut == '-211'
          $sensor.hareket_sag = deger
        elsif komut == '-221'
          $sensor.hareket_sol = deger


        elsif komut == '-31'
          $sensor.ses = deger


        elsif komut == '-41'
          $sensor.isik = deger

        elsif komut == '-511'
          $sensor.yakinlik_on_sag = deger
        elsif komut == '-521'
          $sensor.yakinlik_on_sol = deger

        elsif komut == '-61'
          $sensor.sicaklik = deger

        end
      end
    end
  end


  # THREAD
  def uno_sensor_oku
    Thread.new do
      loop do
        yakinlik_yer = @pins.pin_ara 'yakinlik_yer'
        motor_sag_on = @pins.pin_ara 'motor_sag_on_enkoder'
        motor_sag_arka = @pins.pin_ara 'motor_sag_arka_enkoder'
        motor_sol_on = @pins.pin_ara 'motor_sol_on_enkoder'
        motor_sol_arka = @pins.pin_ara 'motor_sol_arka_enkoder'

        $sensor.yakinlik_yer = @arduino_uno.analog_read yakinlik_yer
        $sensor.motor_sag_on_enkoder = @arduino_uno.analog_read motor_sag_on
        $sensor.motor_sag_arka_enkoder = @arduino_uno.analog_read motor_sag_arka
        $sensor.motor_sol_on_enkoder = @arduino_uno.analog_read motor_sol_on
        $sensor.motor_sol_arka_enkoder = @arduino_uno.analog_read motor_sol_arka

        sleep 0.01
      end
    end
  end


  # SEND ARDUINO
  def uno_transistor gelen
    if gelen == true
      tr1 = @pins.pin_ara 'transistor_1'
      tr2 = @pins.pin_ara 'transistor_2'

      @arduino_uno.digital_write tr1, 1
      @arduino_uno.digital_write tr2, 1

    else
      tr1 = @pins.pin_ara 'transistor_1'
      tr2 = @pins.pin_ara 'transistor_2'

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