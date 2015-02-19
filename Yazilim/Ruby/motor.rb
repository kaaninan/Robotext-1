$LOAD_PATH << '.'
require 'pin'
require 'osc_class'
require 'uzaklik'

class Motor


  def initialize board

    @board = board

    puts '==> Motorlar Etkinlestirildi <=='

    Thread.new do
      motor_kontrol_manual
    end

  end





  def auto_motor
    uzaklikClass = Uzaklik.new @board
    uzakliklar = uzaklikClass.get_uzaklik
  end






  def motor_kontrol_manual
    pins = Pin.new
    osc = OpenS.new

    # Arduino Pin

    motor_sol_on = pins.pin_ara ('motor_sol_on')
    motor_sol_arka = pins.pin_ara ('motor_sol_arka')
    motor_sag_on = pins.pin_ara ('motor_sag_on')
    motor_sag_arka = pins.pin_ara ('motor_sag_arka')

    motor_sol_on_yon = pins.pin_ara ('motor_sol_on_yon')
    motor_sol_arka_yon = pins.pin_ara ('motor_sol_arka_yon')
    motor_sag_on_yon = pins.pin_ara ('motor_sag_on_yon')
    motor_sag_arka_yon = pins.pin_ara ('motor_sag_arka_yon')

    # Osc

    motor_sol_on_etkin = osc.get_item('/Main/etkin_multitoggle/2/1')
    motor_sol_arka_etkin = osc.get_item('/Main/etkin_multitoggle/1/1')
    motor_sag_on_etkin = osc.get_item('/Main/etkin_multitoggle/2/2')
    motor_sag_arka_etkin = osc.get_item('/Main/etkin_multitoggle/1/2')

    motor_sol_ters = osc.get_item('/Main/sol_ters')
    motor_sag_ters = osc.get_item('/Main/sag_ters')


    # Yolla

    @board.analog_write motor_sol_on, osc.get_item('/Main/sol') if motor_sol_on_etkin == 1
    @board.analog_write motor_sol_on, 0 if motor_sol_on_etkin == 0

    @board.analog_write motor_sol_arka, osc.get_item('/Main/sol') if motor_sol_arka_etkin == 1
    @board.analog_write motor_sol_arka, 0 if motor_sol_arka_etkin == 0

    @board.analog_write motor_sag_on, osc.get_item('/Main/sol') if motor_sag_on_etkin == 1
    @board.analog_write motor_sag_on, 0 if motor_sag_on_etkin == 0

    @board.analog_write motor_sag_arka, osc.get_item('/Main/sol') if motor_sag_arka_etkin == 1
    @board.analog_write motor_sag_arka, 0 if motor_sag_arka_etkin == 0

    # Ters - Düz

    @board.digital_write motor_sol_on_yon, 1 if motor_sol_ters == 1
    @board.digital_write motor_sol_on_yon, 0 if motor_sol_ters == 0

    @board.digital_write motor_sol_arka_yon, 0 if motor_sol_ters == 1
    @board.digital_write motor_sol_arka_yon, 1 if motor_sol_ters == 0

    @board.digital_write motor_sag_on_yon, 1 if motor_sag_ters == 1
    @board.digital_write motor_sag_on_yon, 0 if motor_sag_ters == 0

    @board.digital_write motor_sag_arka_yon, 0 if motor_sag_ters == 1
    @board.digital_write motor_sag_arka_yon, 1 if motor_sag_ters == 0

  end


  def stop
  end

end