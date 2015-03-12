require "serialport"

port_str = "/dev/tty.usbmodem1421"
baud_rate = 115200
data_bits = 8
stop_bits = 1
parity = SerialPort::NONE

sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)

while true do
	while (String i = sp.gets.chomp) do
		puts i
		sp.write "test 13\n"
	end
end

sp.close