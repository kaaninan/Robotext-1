require 'arduino'

board = Arduino.new('/dev/tty.usbserial-A603JL3X')

board.output 13

sleep 2

board.setHigh 13

sleep 10
