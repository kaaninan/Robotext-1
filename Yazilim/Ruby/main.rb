require 'rubygems'
require 'arduino_firmata'
require 'pp'
require 'osc'

$LOAD_PATH << '.'
require 'arduino'
require 'osc_class'


## TEST
thr = Thread.new do
  osc = OpenS.new
end



sleep 0.2


# GETS - CONNECT
puts

#print 'Isletim Sistemini Secin (Linux -> 1, Mac -> 2) > '
#$system = gets
#puts

print 'Bagli Kartlari Gormek Ister Misiniz? > '
show = gets

if show.match('e')
  print ArduinoFirmata.list
end
puts
puts


print 'Kullanacaginiz Kartlari Secin (Uno, Mega, Mega 2) > '
gelen_bagli = gets
if gelen_bagli.length > 3

  t_uno_bagli = gelen_bagli.slice(0)
  if t_uno_bagli.match('e')
    uno_etkin = true
  else
    uno_etkin = false
  end

  t_mega_bagli = gelen_bagli.slice(1)
  if t_mega_bagli.match('e')
    mega_etkin = true
  else
    mega_etkin = false
  end

  t_mega2_bagli = gelen_bagli.slice(2)
  if t_mega2_bagli.match('e')
    mega2_etkin = true
  else
    mega2_etkin = false
  end
else
  puts 'HATA: Eksik Giris Yapildi (ErrorCode: 5)'
  exit 1
end
puts


#print 'Kamera'? > '
#@kamera_bagli = gets




# CONNECT - ARDUINO

board = Arduino_Self.new uno_etkin, mega_etkin, mega2_etkin


loop do
  board.f 'led_yak', nil, 'uno'
  sleep 0.5
  board.f 'led_sondur', nil, 'uno'
  sleep 0.5
end


END{
  puts
}