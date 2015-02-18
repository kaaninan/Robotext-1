require 'rubygems'
require 'arduino_firmata'


@arduino = ArduinoFirmata.connect 

puts 'Baglandi'

@arduino.pin_mode 6, ArduinoFirmata::SERVO
@arduino.pin_mode 7, ArduinoFirmata::SERVO

@arduino.pin_mode 26, ArduinoFirmata::INPUT

loop do
	angle = rand 180
	#@arduino.servo_write 6, angle
	#@arduino.servo_write 7, angle
	sleep 0.5
	puts @arduino.digital_read 26
end