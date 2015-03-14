require 'em-websocket'
require 'json'
require 'serialport'
 
sp = SerialPort.new('/dev/tty.usbmodem1421', 9600, 8, 1, SerialPort::NONE)
 
EventMachine::WebSocket.start(:host => 'localhost', :port => 8080) do |ws|
  ws.onopen    { ws.send "hello client" }
  ws.onclose   { puts "WebSocket closed" }
 
  ws.onmessage do
    ws.send message_from(sp).to_json
  end
end
 
def message_from(sp)
  message = sp.gets
  message.chop!
 
  { "event" => message }
end