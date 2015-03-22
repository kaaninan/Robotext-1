require 'websocket-eventmachine-server'
$LOAD_PATH << '.'
require 'log'

class WebSoket

  $yer = 'WebSocket'

  def initialize board
    $sensor = board.getSensor
    $log = LOG.new
  end


  def start
    $log.islem_basladi $yer, 'WebSocket Baslatildi'
    @thr = Thread.new do
      socket
    end
  end

  def stop
    $log.islem_bitti $yer, 'WebSocket Sonlandirildi'
    @thr.exit
  end

  private

  def socket
    EM.run do

      WebSocket::EventMachine::Server.start(:host => 'localhost', :port => 7070) do |ws|
        ws.onopen do
          $log.durum $yer, 'Bir Kullanici Baglandi'
        end

        ws.onmessage do |msg, type|
          puts "Received message: #{msg} Type: #{type}"

          degerler = Array.new
          son = ''
          degerler[0] = "\"isik\":\"#{$sensor.isik}\","
          degerler[1] = "\"sicaklik\":\"#{$sensor.sicaklik}\""

          degerler.each do |i|
            son += i
          end

          ws.send "{#{degerler}}"
        end

        ws.onclose do
          $log.durum $yer, 'Bir Kullanici Ayrildi'
        end
      end

    end
  end


end