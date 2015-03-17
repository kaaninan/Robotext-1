$LOAD_PATH << '.'
require 'include'

EM.run do

  WebSocket::EventMachine::Server.start(:host => "192.168.1.25", :port => 80) do |ws|
    ws.onopen do
      puts "Client connected"
    end

    ws.onmessage do |msg, type|
      puts "Received message: #{msg}"
      ws.send msg, :type => type
    end

    ws.onclose do
      puts "Client disconnected"
    end
  end

end