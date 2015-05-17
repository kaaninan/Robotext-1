require 'rubygems'
require 'arduino_firmata'
require 'serialport'
require 'pp'

$LOAD_PATH << '.'
require 'connect'
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

  $board = Arduino_Connect.new
  $sensor = Sensor.new

  # @gonder = Gonder.new $board
  # @motor = Motor.new $board, @gonder
  # @bashself = BashSelf.new
  # @hareket = Hareket.new $board, @gonder, @motor, @bashself
  # @motor.setGuvenlik @hareket
  # # @osc = OpenS.new $board, @gonder, @motor
  # @mail = MailSelf.new

end



def websocket
  @websocket = WebSoket.new $board, @motor, @hareket, @gonder
  @websocket.start
end




setup


@bashself.kamera 'dosya_olustur'

# @gonder.buzzer 4

websocket
# @mail.mail 'sistem_baslatildi'

@bashself.kamera 'resim_cek'



# @motor.motor_auto_start # Otomatik Motor
# @motor.motor_auto_stop #


# @hareket.stop
# @osc.motor_start
# @osc.motor_stop

# @osc.servo_start
# @osc.servo_stop



loop do
  # @sensor.print_sensor
  sleep 1
end





END{
  $board.close
  @websocket.exit
}
