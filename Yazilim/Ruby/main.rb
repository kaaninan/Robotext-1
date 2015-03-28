require 'rubygems'
require 'arduino_firmata'
require 'serialport'
require 'pp'

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
require 'bashself'

$konum = 'main.rb'


def setup

  # Arduino'ya Bağlan
  $board = Arduino_Self.new
  @sensor = $board.getSensor
  @gonder = Gonder.new $board
  @motor = Motor.new $board, @gonder
  @hareket = Hareket.new $board, @gonder, @motor
  @motor.setGuvenlik @hareket
  # @osc = OpenS.new $board, @gonder, @motor
  @bashself = BashSelf.new

end


puts



def websocket
  @websocket = WebSoket.new $board
  @websocket.start
end


def baslangic_animasyonu
  @gonder.servo 'sag'
  sleep 1
  @gonder.servo 'sol'
  sleep 1
  @gonder.servo nil
  @gonder.ekran_isik 2
  @gonder.ekran 0
  @gonder.buzzer 2
end





setup
sleep 1
baslangic_animasyonu
sleep 1


websocket


# @motor.motor_auto_start # Otomatik Motor
# @motor.motor_auto_stop #


# @hareket.stop

# @osc.motor_start
# @osc.motor_stop

# @osc.servo_start
# @osc.servo_stop




def motor_kontrol_tus

  a = gets.chomp

  if a == 'w'
    @motor.motor_ileri
  elsif a == 's'
    @motor.motor_geri
  elsif a == 'a'
    @motor.motor_sol
  elsif a == 'd'
    @motor.motor_sag
  elsif a == 'q'
    @motor.motor_ileri_sol
  elsif a == 'e'
    @motor.motor_ileri_sag
  elsif a == 'z'
    @motor.motor_dur
  elsif a == 'h'
    @gonder.servo_thread
    @hareket.start
  elsif a == 'j'
    @hareket.stop
    @gonder.servo_thread_stop
  end

  sleep 1
end


loop do
  motor_kontrol_tus
end


# loop do
#   @sensor.print_uzaklik
#   @sensor.print_yakinlik
#   sleep 0.1
# end




END{
  $board.close
  @websocket.exit
}
