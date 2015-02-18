require 'rubygems'
require 'arduino_firmata'
require 'pp'
require 'osc'

$LOAD_PATH << '.'
require 'arduino'
require 'osc_class'
require 'pin'


# SEÇİMLER VE ARDUINO BAĞLANMA #
puts



## Bağlı Kartlar
print 'Bagli Kartlari Gormek Ister Misiniz? > '
show = gets

if show.match('e')
  print ArduinoFirmata.list
end
puts
puts



## Kullanılan Kartlar
print 'Kullanacaginiz Kartlari Secin (Mega, Mega 2) > '
gelen_bagli = gets
if gelen_bagli.length > 2

  t_mega_bagli = gelen_bagli.slice(0)
  if t_mega_bagli.match('e')
    @mega_etkin = true
  else
    @mega_etkin = false
  end

  t_mega2_bagli = gelen_bagli.slice(1)
  if t_mega2_bagli.match('e')
    @mega2_etkin = true
  else
    @mega2_etkin = false
  end
else
  puts 'HATA: Eksik Giris Yapildi (ErrorCode: 5)'
  exit 1
end
puts
puts

## Bağlı Kartlar
print 'OSC Etkinlestirilsin Mi? > '
show = gets

if show.match('e')
  @osc_etkin = true
end
puts
puts



## Arduino Connect

$board = Arduino_Self.new @mega_etkin, @mega2_etkin
puts


# MAIN #


## SETUP

def setup
  ## LOG
  puts '=> Running: Main -> Setup -> PinMode'
  pins = Pin.new
  $board.pinMode pins.megaPin, 'mega'
  puts '=> Finished: Main -> Setup -> PinMode'
  puts
end

setup


thr = Thread.new do
  if @osc_etkin
    $osc = OpenS.new
    $osc.start
  end
end


$board.f 'hareket_basla', nil, 'mega'


loop do

end


END{
  puts
}