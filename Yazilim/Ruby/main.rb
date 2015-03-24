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



setup
sleep 0.5
baslangic_animasyonu

websocket
sleep 0.1



# @motor.motor_auto_start # Otomatik Motor
# @motor.motor_auto_stop #

# @hareket.start
# @hareket.stop
  

loop do
  sleep 1
end




END{
  $board.close
  @websocket.exit
  puts
}