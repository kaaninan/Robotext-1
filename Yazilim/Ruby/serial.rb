require 'serialport'

port_str = '/dev/tty.usbmodem1421'
sp = SerialPort.new(port_str, 115200, 8, 1, SerialPort::NONE)



sp.close