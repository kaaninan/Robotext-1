#!/usr/bin/env ruby
require 'rubygems'

arduino = ArduinoFirmata.connect '/dev/tty.usbserial-A603JL3X'

puts 'Bağlandı'

#arduino.pin_mode 2, ArduinoFirmata::INPUT
#arduino.pin_mode 3, ArduinoFirmata::INPUT
arduino.pin_mode 6, ArduinoFirmata::SERVO
arduino.pin_mode 7, ArduinoFirmata::SERVO






loop do
  puts "yaz"
  @kaan = gets
  arduino.servo_write 6, 120
  puts 'bitti'
  sleep 0.2
end
