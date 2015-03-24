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


$konum = 'main.rb'


def setup

  # Arduino'ya Bağlan
  $board = Arduino_Self.new
  @motor = Motor.new $board
  @sensor = $board.getSensor

end

puts







## SERIAL
def mega_gonder
  $board.mega_serial_gonder 'sensorler', nil
end


## SENSOR
def sensor_yaz
  #$board.getSensor.print_sensor
  $board.getSensor.print_uzaklik
  $board.getSensor.print_uzaklik2
  $board.getSensor.print_yakinlik
  #$board.getSensor.print_uno
  #$board.getSensor.print_enkoder
end



## WEBSOCKET
def websocket
  @websocket = WebSoket.new $board
  @websocket.start
end



setup # Arduino Bağlantısı
#websocket
sleep 0.1



# @motor.motor_auto_start # Otomatik Motor
# @motor.motor_klavye_tus # Klavye Motor



loop do
  mega_gonder # Mega'ya veri gönderme
  @sensor_yaz # Sensorlerin verilerini print serial
  sleep 0.1
end




END{
  $board.close
  @websocket.exit
  puts
}