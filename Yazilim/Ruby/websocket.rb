require 'websocket-eventmachine-server'
$LOAD_PATH << '.'
require 'motor'
require 'gonder'

class WebSoket
    
  $ip = '192.168.1.25'

  $yer = 'WebSocket'

  def initialize board, motor, hareket, gonder
    $sensor = board.getSensor
    $motor = motor
    @hareket = hareket
    @gonder = gonder
  end


  def start
    $log.islem_basladi $yer, 'WebSocket Baslatildi'
    @thr = Thread.new do
      socket
    end

    gonder

  end

  
  def stop
    $log.islem_bitti $yer, 'WebSocket Sonlandirildi'
    @thr.exit
  end

  private

  def socket
    EM.run do

    WebSocket::EventMachine::Server.start(:host => $ip, :port => 7070) do |ws|
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
  

  def parse komut

    yeni = komut.to_s.split '"', 10

    if yeni[1].chomp == 'etkin_guvenlik'
      if yeni[3].chomp == 'acik'
        puts 'Guvenlik Acildi'
        @hareket.start
      else
        puts 'Guvenlik Kapatildi'
        @hareket.stop
      end
    end

    if yeni[1].chomp == 'etkin_otomatik'
      if yeni[3].chomp == 'acik'
        puts 'Otomatik Mod'
        $motor.motor_auto_basla
      else
        puts 'Manual Mod'
        $motor.motor_auto_stop
      end
    end

    if yeni[1].chomp == 'etkin_alarm'
      if yeni[3].chomp == 'acik'
        puts 'Alarm Acik'
        @gonder.buzzer 1
      else
        puts 'Alarm Kapali'
        @gonder.buzzer 0
      end
    end

    if yeni[1].chomp == 'etkin_motor'
      if yeni[3].chomp == 'ileri'
        $motor.motor_ileri
        puts 'Motor Ileri'
      elsif yeni[3].chomp == 'geri'
        $motor.motor_geri
        puts 'Motor Geri'
      elsif yeni[3].chomp == 'sag'
        $motor.motor_sag
        puts 'Motor Sag'
      elsif yeni[3].chomp == 'sol'
        $motor.motor_sol
        puts 'Motor Sol'
      elsif yeni[3].chomp == 'dur'
        $motor.motor_dur
        puts 'Motor Dur'
      end
    end

  end


  def gonder

    Thread.new do
      loop do
        degerler = Array.new
        son = ''
        degerler[0] = "\"isik\":\"#{$sensor.isik}\","
        degerler[1] = "\"sicaklik\":\"#{$sensor.sicaklik}\","
        degerler[2] = "\"uzaklik_on_sag\":\"#{$sensor.uzaklik_on_sag}\","
        degerler[3] = "\"uzaklik_on_sol\":\"#{$sensor.uzaklik_on_sol}\","
        degerler[4] = "\"hareket_sag\":\"#{$sensor.hareket_sag}\","
        degerler[5] = "\"hareket_sol\":\"#{$sensor.hareket_sol}\","
        degerler[6] = "\"motor_sag_on_enkoder\":\"#{$sensor.motor_sag_on_enkoder}\","
        degerler[7] = "\"motor_sag_arka_enkoder\":\"#{$sensor.motor_sag_arka_enkoder}\","
        degerler[8] = "\"motor_sol_on_enkoder\":\"#{$sensor.motor_sol_on_enkoder}\","
        degerler[9] = "\"motor_sol_arka_enkoder\":\"#{$sensor.motor_sol_arka_enkoder}\","
        degerler[10] = "\"gaz\":\"#{$sensor.gaz}\","
        degerler[11] = "\"ses\":\"#{$sensor.ses}\""
        

        degerler.each do |i|
          son += i
        end

        ws.send "{#{son}}"
        sleep 0.1
      end
    end

  end


end