#!/usr/bin/env ruby
require 'rubygems'
require 'arduino_firmata'

arduino = ArduinoFirmata.connect '/dev/tty.usbserial-A603JL3X', :nonblock_io => true

puts 'Bağlandı'

arduino.pin_mode 2, ArduinoFirmata::INPUT
#arduino.pin_mode 3, ArduinoFirmata::INPUT
arduino.pin_mode 22, ArduinoFirmata::INPUT



arduino.on :digital_read do |pin, status|
    puts "#{pin}, #{status}"
end


loop do
  sleep 0.2
end
