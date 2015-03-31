require 'rubygems'
require 'arduino_firmata'
require 'serialport'
require 'pp'

$LOAD_PATH << '.'
require 'arduino'
# require 'osc_class'
require 'pin'
require 'motor'
require 'hareket'
require 'log'
require 'sensor'
require 'websocket'
require 'gonder'
require 'bashself'
require 'mail'

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
  @mail = MailSelf.new

end


puts



def websocket
  @websocket = WebSoket.new $board, @motor, @hareket
  @websocket.start
end


def baslangic_animasyonu
  Thread.new do
    @gonder.servo 'sag'
    sleep 0.5
    @gonder.servo 'sol'
    sleep 0.5
    @gonder.servo nil
  end

  @gonder.ekran_isik 2
  $board.deger_ekran = 0
  # @gonder.buzzer 4
end





setup
# sleep 1
# baslangic_animasyonu
# sleep 1


@bashself.ses 'acildi'

@bashself.kamera 'dosya_olustur'

@gonder.buzzer 4

websocket
@mail.mail 'sistem_baslatildi', "kaaninan@outlook.com"

$board.arduino_sms 'basla'


# @motor.motor_auto_start # Otomatik Motor
# @motor.motor_auto_stop #


# @hareket.stop
# @osc.motor_start
# @osc.motor_stop

# @osc.servo_start
# @osc.servo_stop



def motor_kontrol_tus

  @a = gets.chomp

  if @a == 'w'
    @motor.motor_ileri
  elsif @a == 's'
    @motor.motor_geri
  elsif @a == 'a'
    @motor.motor_sol
  elsif @a == 'd'
    @motor.motor_sag
  elsif @a == 'q'
    @motor.motor_ileri_sol
  elsif @a == 'e'
    @motor.motor_ileri_sag
  elsif @a == 'z'
    @motor.motor_dur

  elsif @a == 'h'

  elsif @a == 'j'
    @hareket.stop

  elsif @a == 'b'
    @motor.motor_auto_basla
  elsif @a == 'n'
    @motor.motor_auto_stop

  end


  sleep 1
end


loop do
  # motor_kontrol_tus
  # @sensor.print_sonic
end


# loop do
#
#   sleep 0.1
# end




END{
  $board.close
  @websocket.exit
}
