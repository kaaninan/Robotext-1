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

  if yeni[1].chomp == 'etkin_otomatik'
    if yeni[3].chomp == 'acik'
      puts 'Otomatik Mod'
    else
      puts 'Manual Mod'
    end
  end

  if yeni[1].chomp == 'etkin_alarm'
    if yeni[3].chomp == 'acik'
      puts 'Alarm Acik'
    else
      puts 'Alarm Kapali'
    end
  end

  if yeni[1].chomp == 'etkin_motor'
    if yeni[3].chomp == 'ileri'
      puts 'Motor Ileri'
    elsif yeni[3].chomp == 'geri'
      puts 'Motor Geri'
    elsif yeni[3].chomp == 'sag'
      puts 'Motor Sag'
    elsif yeni[3].chomp == 'sol'
      puts 'Motor Sol'
    elsif yeni[3].chomp == 'dur'
      puts 'Motor Dur'
    end
  end

end

def socket
  EM.run do

    WebSocket::EventMachine::Server.start(:host => '192.168.1.26', :port => 7070) do |ws|
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