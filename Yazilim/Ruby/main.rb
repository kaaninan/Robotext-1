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
require 'bashself'

$konum = 'main.rb'


def setup

  # Arduino'ya Bağlan
  $board = Arduino_Self.new
  @gonder = Gonder.new $board
  $board.setGonder @gonder
  @motor = Motor.new $board
  @sensor = $board.getSensor
  @hareket = Hareket.new $board, @gonder
  @osc = OpenS.new $board, @gonder, @motor
  @bashself = BashSelf.new

  # SERVO THREAD
  # @gonder.servo_thread
  # @gonder.servo nil
end


puts



def websocket
  @websocket = WebSoket.new $board
  @websocket.start
end


def baslangic_animasyonu
  @gonder.servo_selam
  @gonder.ekran_isik 'kirp'
  @gonder.ekran '0'
  @gonder.buzzer 'acilis'
end


def default
  Thread.new do
    loop do
      @gonder.ekran_isik 'yak'
      @gonder.ekran '0'
      @gonder.buzzer 'sus'
      sleep 2
    end
  end
end



setup
sleep 2
# baslangic_animasyonu
# sleep 2


# @gonder.servo_thread
default
websocket

@gonder.servo_thread
@gonder.servo nil
sleep 2
@gonder.servo_thread_stop


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


sleep 2

# @motor.motor_auto_start


# loop do
#   @sensor.print_uzaklik
#   @sensor.print_uzaklik2
#   @sensor.print_yakinlik
#   sleep 0.1
# end

END{
  @gonder.ekran_isik 'sondur'
  $board.close
  @websocket.exit
  puts
}
