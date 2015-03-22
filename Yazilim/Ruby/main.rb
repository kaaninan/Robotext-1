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

end

puts







@motor = Motor.new $board

## MOTOR
def motor_auto
  @motor.motor_auto_start
end


def motor_kontrol
  loop do
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
    end
  end
end


## SERIAL
def mega_gonder
  $board.mega_serial_gonder 'sensorler', nil
end


## SENSOR
def sensor_yaz
  $board.getSensor.print_sensor
  #$board.getSensor.print_uzaklik
  #$board.getSensor.print_uzaklik2
  #$board.getSensor.print_yakinlik
  #$board.getSensor.print_uno
  #$board.getSensor.print_enkoder
end



## WEBSOCKET
def websocket
  @websocket = WebSoket.new $board
  @websocket.start
end



#setup # Arduino Bağlantısı
#websocket
#motor_auto
#motor_kontrol # Klavyeden motor kontrolü

loop do
  mega_gonder # Mega'ya veri gönderme
  sensor_yaz # Sensorlerin verilerini yazdırma
  sleep 0.1
end







END{
  $board.close
  @websocket.exit
  puts
}