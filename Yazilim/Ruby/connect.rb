require 'rubygems'
require 'arduino_firmata'
require 'serialport'
require 'pp'
$LOAD_PATH << '.'
require 'log'
require 'pin'

# Arduino Baglantisi ve PinMode
# with Firmata

class Arduino_Connect

  $konum = 'Arduino_Self'

  @bagli_uno = false
  @bagli_mega = false

  
  def initialize
    $log = LOG.new

    baglan
    pinMode

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
      @arduino_uno = ArduinoFirmata.connect @boards_uno, :nonblock_io => true
      $log.islem_bitti $konum, "Arduino Uno'ya Baglanildi"
      @bagli_uno = true
    elsif !@boards_uno
      @arduino_uno = nil
      $log.hata $konum, 'Baglanilmak istenen kart bulunamadi! (Kart: Arduino Uno)'
    end

    if @boards_mega
      @arduino_mega = ArduinoFirmata.connect @boards_mega, :nonblock_io => true
      $log.islem_bitti $konum, "Arduino Mega'ya Baglanildi"
      @bagli_mega = true
    elsif !@boards_mega
      @arduino_mega = nil
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
  def pinMode

    @pins = Pin.new

    @tip = nil
    @pin = nil
    @aciklama = nil

    if @bagli_uno
      array = @pins.getPinUno
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


    if @bagli_mega
      array = @pins.getPinMega
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
        @arduino_mega.pin_mode @pin, @tip
      end
    else
      $log.hata $konum, 'PinMode Yapilamadi, Arduino Mega Bagli Degil'
    end

  end


  public

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
    if @bagli_uno
      @arduino_uno.close
    end

    if @bagli_mega
      @arduino_mega.close
    end
  end

end