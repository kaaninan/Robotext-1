$LOAD_PATH << '.'
require 'include'


$konum = 'main.rb'


def setup

  # Arduino'ya Bağlan
  $board = Arduino_Self.new

end

puts
setup







## MOTOR
def motor
  @motor = Motor.new $board.getUno
  @motor.motor_auto_start
end



## SERIAL
def mega_gonder
  $board.mega_serial_gonder 'sensorler', nil
end



## SENSOR
def sensor
  $board.getSensor.print_sensor
  #$board.getSensor.print_uzaklik
  #$board.getSensor.print_yakinlik
  #$board.getSensor.print_uno
end





loop do
  sleep 0.1
end






END{
  $board.close
  puts
}