# TEST - TAMAMLANDI

require 'pp'
require 'arduino_firmata'

print 'Arduino Bağlı Mı? (Uno, Mega, Mega2) > '
gelen_bagli = gets

if gelen_bagli.length > 3
  
  t_uno_bagli = gelen_bagli.slice(0)
  if t_uno_bagli.match("e")
    uno_bagli = true
  else
    uno_bagli = false
  end

  t_mega_bagli = gelen_bagli.slice(1)
  if t_mega_bagli.match("e")
    mega_bagli = true
  else
    mega_bagli = false
  end

  t_mega2_bagli = gelen_bagli.slice(2)
  if t_mega2_bagli.match("e")
    mega2_bagli = true
  else
    mega2_bagli = false
  end
else
  puts "HATA: Eksik Giriş Yapıldı"
  exit 1
end

usb = Array["/dev/ttyACM0", "/dev/ttyUSB0", "/dev/ttyUSB1"]
usb2 = Array["/dev/tty.usbserial-A603JL3X", "/dev/tty.usbmodem1421"]

def ayir

  boards = Array.new

  usb.each do |i|

    if i.match('USB0')
      print 'linux mega -> '
      puts i
      if mega_bagli
        boards << i
      end
    end

    if i.match('USB1')
      print 'linux mega2 -> '
      puts i
      if mega2_bagli
        boards << i
      end
    end

    if i.match('ACM')
      print 'linux uno -> '
      puts i
      if uno_bagli
        boards << i
      end
    end

    if i.match('usbserial-A603JL3X')
      print 'mac mega -> '
      puts i
      if mega_bagli
        boards << i
      end
    end

    if i.match('usbmodem')
      print 'mac uno -> '
      puts i
      if uno_bagli
        boards << i
      end
    end
  end 
end

ayir
puts
puts "Boards"
pp boards