require 'rubygems'
require 'arduino_firmata'
require 'serialport'
require 'pp'
require 'osc'

$LOAD_PATH << '.'
require 'arduino'
require 'osc_class'
require 'pin'
require 'motor'
require 'hareket'
require 'log'
require 'sensor'
require 'websocket'
require 'gonder'


$konum = 'main.rb'


def setup

  # Arduino'ya Bağlan
  $board = Arduino_Self.new
  @gonder = Gonder.new $board
  $board.setGonder @gonder
  @motor = Motor.new $board
  @sensor = $board.getSensor
  @hareket = Hareket.new $board
  @osc = OpenS.new $board, @gonder

  # SERVO THREAD
  @gonder.servo_thread

end


puts



def websocket
  @websocket = WebSoket.new $board
  @websocket.start
end


def baslangic_animasyonu
  Thread.new do
    @gonder.servo_selam
  end
  Thread.new do
    @gonder.ekran_isik 'kirp'
  end
  Thread.new do
    @gonder.ekran '0'
  end
  Thread.new do
    @gonder.buzzer 'acilis'
  end
end



setup
sleep 2
baslangic_animasyonu
sleep 2

websocket



# @motor.motor_auto_start # Otomatik Motor
# @motor.motor_auto_stop #

# @hareket.start
# @hareket.stop

# @osc.motor_start
# @osc.motor_stop

# @osc.servo_start
# @osc.servo_stop


# loop do
#   @sensor.print_uzaklik
#   @sensor.print_uzaklik2
#   @sensor.print_yakinlik
#   sleep 0.1
# end


loop do
  a = gets.chomp

  if a == 'a'
    @motor.motor_auto_start # Otomatik Motor
  elsif b == 'b'
    @motor.motor_auto_stop #
  end

  @gonder.servo 'orta'

  sleep 0.1

end

END{
  $board.close
  @websocket.exit
  puts
}
