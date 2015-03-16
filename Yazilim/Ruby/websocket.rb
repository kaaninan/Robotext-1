require 'websocket-eventmachine-server'

EM.run do

  WebSocket::EventMachine::Server.start(:host => "localhost", :port => 7070) do |ws|
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