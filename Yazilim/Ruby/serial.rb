require 'serialport'

port_str = '/dev/tty.usbserial-A603JL3X'
@sp = SerialPort.new(port_str, 57600, 8, 1, SerialPort::NONE)


Thread.new do
  sleep 3
  getir
  sleep 2
  #uzaklik
end

Thread.new do
  geliyor
end


def geliyor
  loop do
      puts @sp.gets
  end
end


def getir
  @sp.write '-11&'
  @sp.write '-11&'
  @sp.write '-11&'
end


def uzaklik
  loop do
    @sp.write '-11 0'
    @sp.write '\n'
    puts 'YAZ'
    sleep 1
  end
end

loop do
  sleep 1
end