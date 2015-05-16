require 'rubygems'
require 'osc'
require 'arduino_firmata'




def baglan
  @arduino_serial = Array(ArduinoFirmata.list)
  choose_board (@arduino_serial)
  @arduino_uno = ArduinoFirmata.connect @boards_uno, :nonblock_io => true
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
  @arduino_uno_pin = Hash.new
  @arduino_uno_pin = {
      {2 => 'motor_sag_on_yon'} => 1,
      {3 => 'motor_sag_on_hiz'} => 1,
      {4 => 'motor_sag_arka_yon'} => 1,
      {5 => 'motor_sag_arka_hiz'} => 1,
      {6 => 'motor_sol_on_hiz'} => 1,
      {7 => 'motor_sol_on_yon'} => 1,
      {8 => 'motor_sol_arka_yon'} => 1,
      {9 => 'motor_sol_arka_hiz'} => 1
  }

  @arduino_uno_pin.each do |a, b|

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
end


def motor hiz_sag, hiz_sol, sag_ters, sol_ters

  if sag_ters == 0
    @arduino_uno.digital_write @y_sag_on, 0
    @arduino_uno.digital_write @y_sag_arka, 1
  else
    @arduino_uno.digital_write @y_sag_on, 1
    @arduino_uno.digital_write @y_sag_arka, 0
  end

  if sol_ters == 0
    @arduino_uno.digital_write @y_sol_on, 0
    @arduino_uno.digital_write @y_sol_arka, 1
  else
    @arduino_uno.digital_write @y_sol_on, 1
    @arduino_uno.digital_write @y_sol_arka, 0
  end

  @arduino_uno.analog_write @h_sag_on, hiz_sag
  @arduino_uno.analog_write @h_sag_arka, hiz_sag
  @arduino_uno.analog_write @h_sol_on, hiz_sol
  @arduino_uno.analog_write @h_sol_arka, hiz_sol
end


def osc

  $eski_liste = Array[
      'sol',
      'sag',
      'sol_ters',
      'sag_ters',
      'etkin_multitoggle/1/1',
      'etkin_multitoggle/1/2',
      'etkin_multitoggle/2/1',
      'etkin_multitoggle/2/2',
      'buzzer',
      'servo_1',
      'servo_2'
  ]

  $osc_liste = Hash.new

  # OSC ID Listesi Oluşturma
  $eski_liste.each do |i|
    item = Hash['/Main/'+i => 0]
    $osc_liste.merge!(item)
  end

  osc_start

end
def osc_start
  OSC.using(:input_port => 8000) do
    $osc_liste.each do |a, b|
      receive(a) do |val|
        $osc_liste[a] = val.to_i
      end
    end
    p "OSC Hazir, Port: #{input_ports.join(', ')}"
    wait_for_input
  end
end


def motor_start
  @thr = Thread.new do
    loop do
      motor $osc_liste['/Motor/sag'], $osc_liste['/Motor/sol'], $osc_liste['/Motor/sag_ters'], $osc_liste['/Motor/sol_ters']
      sleep 0.1
    end
  end
end
def motor_stop
  @thr.exit
end


baglan
sleep 0.1
pin_mode
sleep 0.1
osc

loop do
  puts $osc_liste
end