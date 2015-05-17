require 'rubygems'
require 'arduino_firmata'
require 'serialport'
require 'pp'
$LOAD_PATH << '.'
require 'log'
require 'pin'

class Arduino_Self

  attr_accessor :sysex_uzaklik, :sysex_hareket, :sysex_ses

  def initialize arduino_uno, arduino_mega, sensor

    @arduino_uno = arduino_uno
    @arduino_mega = arduino_mega
    @sensor = sensor

    # Default
    @sysex_uzaklik = false
    @sysex_hareket = false
    @sysex_ses = false

    # Bagli Olup Olmadigini Kontrol Et
    if @arduino_mega != nil
      @bagli_mega = true
    else
      @bagli_mega = false
    end
    if @arduino_uno != nil
      @bagli_uno = true
    else
      @bagli_uno = false
    end

    sysexGelen
    sysexGonder

  end


  def sysexGelen

    if @bagli_uno
      @arduino_uno.on :sysex do |command, data|
        if command == 113
          komut = data.pack('c*')
          komutArray = komut.split(' ')
        end
      end
    end

    if @bagli_mega
      Thread.new do
        puts 'sysex gelen'
        @arduino_mega.on :sysex do |command, data|
          if command == 113
            komut = data.pack('c*')
            komutArray = komut.split(' ')
            degisken = komutArray[0].to_i

            if degisken == 0
              @sensor.ses = komutArray[1].to_i
            elsif degisken == 1
              @sensor.uzaklik_on_sag = komutArray[1].to_i
            elsif degisken == 2
              @sensor.uzaklik_on_sol = komutArray[1].to_i
            elsif degisken == 3
              @sensor.hareket_sag = komutArray[1].to_i
            elsif degisken == 4
              @sensor.hareket_sol = komutArray[1].to_i
            end

          end
        end
      end
    end

  end

  def sysexGonder
    Thread.new do
      @pin = Pin.new
      if @bagli_mega
        ses = @pin.pin_ara_mega 'ses'
        hareket_sag = @pin.pin_ara_mega 'hareket_sag'
        hareket_sol = @pin.pin_ara_mega 'hareket_sol'
        trig_sag = @pin.pin_ara_mega 'trig_sag'
        echo_sag = @pin.pin_ara_mega 'echo_sag'
        trig_sol = @pin.pin_ara_mega 'trig_sol'
        echo_sol = @pin.pin_ara_mega 'echo_sol'
        loop do
          if @sysex_uzaklik == true
            @arduino_mega.sysex 0x03, [trig_sag, echo_sag, 0] # Sag
            sleep 0.01
            @arduino_mega.sysex 0x03, [trig_sol, echo_sol, 1] # Sol
            sleep 0.01
          end
          if @sysex_hareket == true
            @arduino_mega.sysex 0x04, [0, hareket_sag, 0] # Sag
            sleep 0.01
            @arduino_mega.sysex 0x04, [1, hareket_sol, 0] # Sol
            sleep 0.01
          end
          if @sysex_ses == true
            @arduino_mega.sysex 0x02, [ses, 0, 0]
            sleep 0.01
          end
          sleep 2
          puts 'Döngü'
        end
      end
    end
  end

  def sysexKomut secenek, deger
    if @bagli_mega
      if secenek == 'ekran'
        @arduino_mega.sysex 0x01, [0, deger, 0]
        sleep 0.01
      end
    end
  end

  # Getter
  def getUno
    return @arduino_uno
  end
  def getMega
    return @arduino_mega
  end

end