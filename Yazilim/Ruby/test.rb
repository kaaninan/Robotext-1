require 'websocket-eventmachine-server'


def parse komut

  yeni = komut.to_s.split '"', 10

  if yeni[1].chomp == 'etkin_guvenlik'
    if yeni[3].chomp == 'acik'
      puts 'Guvenlik Acildi'
    else
      puts 'Guvenlik Kapatildi'
    end
  end

end

def socket
  EM.run do

    WebSocket::EventMachine::Server.start(:host => 'localhost', :port => 7070) do |ws|
      ws.onopen do
        puts 'acik'
      end

      ws.onmessage do |msg, type|
        parse msg
      end

      ws.onclose do
        puts 'ayrildi'
      end
    end

  end
end

def gonder

  Thread.new do
    loop do
      degerler = Array.new
      son = ''
      degerler[0] = "\"isik\":\"60\","
      degerler[1] = "\"sicaklik\":\"25\""

      degerler.each do |i|
        son += i
      end

      ws.send "{#{son}}"
      sleep 0.1
    end
  end

end

Thread.new do
  gonder
end
socket
gets