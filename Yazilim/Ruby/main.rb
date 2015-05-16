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
  @bashself = BashSelf.new
  @hareket = Hareket.new $board, @gonder, @motor, @bashself
  @motor.setGuvenlik @hareket
  # @osc = OpenS.new $board, @gonder, @motor
  @mail = MailSelf.new

end


puts



def websocket
  @websocket = WebSoket.new $board, @motor, @hareket, @gonder
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


@bashself.ses 'acildi'

@bashself.kamera 'dosya_olustur'

@gonder.buzzer 4

websocket
@mail.mail 'sistem_baslatildi'

@bashself.kamera 'resim_cek'

$board.uno_sms 1


# @motor.motor_auto_start # Otomatik Motor
# @motor.motor_auto_stop #


# @hareket.stop
# @osc.motor_start
# @osc.motor_stop

# @osc.servo_start
# @osc.servo_stop



loop do
  @sensor.print_sensor
end





END{
  $board.close
  @websocket.exit
}
