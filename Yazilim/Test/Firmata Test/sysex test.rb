require 'rubygems'
require 'arduino_firmata'

arduino = ArduinoFirmata.connect ARGV.shift
puts "firmata version #{arduino.version}"

## regist event
arduino.on :sysex do |command, data|
  puts "command : #{command}"
  puts "data    : #{data.inspect}"
end

## send sysex command
arduino.sysex 0x01, ['k','a','a','n']
arduino.sysex 0x02, ['k','a','a','n']


# => 0x01 -> Ekran Sağ
# => 0x02 -> Ekran Sol

# => ['k','a','a','n'] 




loop do
  sleep 1
end