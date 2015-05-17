#!/usr/bin/env ruby
$:.unshift File.expand_path '../../lib', File.dirname(__FILE__)
require 'rubygems'
require 'arduino_firmata'

arduino = ArduinoFirmata.connect ARGV.shift
puts "firmata version #{arduino.version}"

## regist event
arduino.on :sysex do |command, data|
  if command == 113
    gelen = data.pack('c*')
    gelen2 = gelen.split(' ')

    puts gelen2[0].to_i == 0

  end
end


# UZAKLIK PIN
arduino.pin_mode 36, ArduinoFirmata::OUTPUT
arduino.pin_mode 37, ArduinoFirmata::INPUT
arduino.pin_mode 38, ArduinoFirmata::OUTPUT
arduino.pin_mode 39, ArduinoFirmata::INPUT


arduino.pin_mode 27, ArduinoFirmata::OUTPUT # Ekran ışık
arduino.pin_mode 24, ArduinoFirmata::OUTPUT # Buzzer

# SERVO
arduino.pin_mode 2, ArduinoFirmata::SERVO
arduino.pin_mode 3, ArduinoFirmata::SERVO


arduino.digital_write 27, true

arduino.servo_write 2, 85
arduino.servo_write 3, 100

# BUZZER
# arduino.digital_write 24, true
# sleep 0.1
# arduino.digital_write 24, false
# sleep 0.1
# arduino.digital_write 24, true
# sleep 0.1
# arduino.digital_write 24, false

# EKRAN
# arduino.sysex 0x01, [0, 1, 0]
# sleep 2
# arduino.sysex 0x01, [0, 0, 0]


# Hareket
arduino.pin_mode 22, ArduinoFirmata::INPUT
arduino.pin_mode 23, ArduinoFirmata::INPUT

# Ses
arduino.pin_mode 26, ArduinoFirmata::INPUT


50.times do
  arduino.sysex 0x02, [26, 0, 0] # Ses
  sleep 0.01
end


arduino.close