$LOAD_PATH << '.'
require 'pin'
require 'osc_class'

class Uzaklik


  def initialize board

    @board = board

    puts '==> Uzaklik Okuma Etkinlestirildi <=='

    thread = Thread.new do
      uzaklik_oku
    end

  end




  def get_uzaklik

    pins = Pin.new

    # Kızılötesi

    @uzaklik_sag_on = @board.analog_read pins.pin_ara('uzaklik_sag_on')
    @uzaklik_sag_arka = @board.analog_read pins.pin_ara('uzaklik_sag_arka')

    @uzaklik_sol_on = @board.analog_read pins.pin_ara('uzaklik_sol_on')
    @uzaklik_sol_arka = @board.analog_read pins.pin_ara('uzaklik_sol_arka')

    # Ultrasonic

    @uzaklik_on_alt_1 = @board.digital_read pins.pin_ara('uzaklik_on_alt_1')
    @uzaklik_on_alt_2 = @board.digital_read pins.pin_ara('uzaklik_on_alt_2')

    @uzaklik_on_ust_1 = @board.digital_read pins.pin_ara('uzaklik_on_ust_1')
    @uzaklik_on_ust_2 = @board.digital_read pins.pin_ara('uzaklik_on_ust_2')

    @uzaklik_arka_1 = @board.digital_read pins.pin_ara('uzaklik_arka_1')
    @uzaklik_arka_2 = @board.digital_read pins.pin_ara('uzaklik_arka_2')

    ## Ultrasonic Converter - On Alt

    # Yakinlik Derecesi
    # => 0 - 1 - 2 - 3 (Yakından Uzağa)

    @uzaklik_seviye_on_alt = 0 if @uzaklik_on_alt_1 == ArduinoFirmata::HIGH && @uzaklik_on_alt_2 == ArduinoFirmata::HIGH # 1-1
    @uzaklik_seviye_on_alt = 1 if @uzaklik_on_alt_1 == ArduinoFirmata::HIGH && @uzaklik_on_alt_2 == ArduinoFirmata::LOW # 1-0
    @uzaklik_seviye_on_alt = 2 if @uzaklik_on_alt_1 == ArduinoFirmata::LOW && @uzaklik_on_alt_2 == ArduinoFirmata::HIGH # 0-1
    @uzaklik_seviye_on_alt = 3 if @uzaklik_on_alt_1 == ArduinoFirmata::LOW && @uzaklik_on_alt_2 == ArduinoFirmata::LOW # 0-0

    @uzaklik_seviye_on_ust = 0 if @uzaklik_on_ust_1 == ArduinoFirmata::HIGH && @uzaklik_on_ust_2 == ArduinoFirmata::HIGH # 1-1
    @uzaklik_seviye_on_ust = 1 if @uzaklik_on_ust_1 == ArduinoFirmata::HIGH && @uzaklik_on_ust_2 == ArduinoFirmata::LOW # 1-0
    @uzaklik_seviye_on_ust = 2 if @uzaklik_on_ust_1 == ArduinoFirmata::LOW && @uzaklik_on_ust_2 == ArduinoFirmata::HIGH # 0-1
    @uzaklik_seviye_on_ust = 3 if @uzaklik_on_ust_1 == ArduinoFirmata::LOW && @uzaklik_on_ust_2 == ArduinoFirmata::LOW # 0-0

    @uzaklik_seviye_arka = 0 if @uzaklik_arka_1 == ArduinoFirmata::HIGH && @uzaklik_arka_2 == ArduinoFirmata::HIGH # 1-1
    @uzaklik_seviye_arka = 1 if @uzaklik_arka_1 == ArduinoFirmata::HIGH && @uzaklik_arka_2 == ArduinoFirmata::LOW # 1-0
    @uzaklik_seviye_arka = 2 if @uzaklik_arka_1 == ArduinoFirmata::LOW && @uzaklik_arka_2 == ArduinoFirmata::HIGH # 0-1
    @uzaklik_seviye_arka = 3 if @uzaklik_arka_1 == ArduinoFirmata::LOW && @uzaklik_arka_2 == ArduinoFirmata::LOW # 0-0


    # Ham Veri
    @uzakliklar = Hash.new
    @uzakliklar = {'uzaklik_sag_on' => @uzaklik_sag_on,
                   'uzaklik_sag_arka' => @uzaklik_sag_arka,
                   'uzaklik_sol_on' => @uzaklik_sol_on,
                   'uzaklik_sol_arka' => @uzaklik_sol_arka,
                   'uzaklik_on_alt' => @uzaklik_seviye_on_alt,
                   'uzaklik_on_ust' => @uzaklik_seviye_on_ust,
                   'uzaklik_arka' => @uzaklik_seviye_arka,
    }

    return @uzakliklar
  end


end