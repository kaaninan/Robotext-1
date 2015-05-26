require 'rubygems'
require 'serialport'
require 'pp'

$LOAD_PATH << '.'
require 'var'
require 'arduino'
require 'pin'
require 'yangin'
require 'motor'
require 'hareket'
require 'log'
require 'websocket'
require 'bashself'
require 'mail'

$konum = 'main.rb'


def setup

  # Arduino'ya Bağlan
  $var = Var.new
  $board = Arduino_Self.new $var

  @motor = Motor.new $board, $var
  @hareket = Hareket.new $board, @motor, $var
  @yangin = Yangin.new $board, $var

  @motor.setGuvenlik @hareket

  @bashself = BashSelf.new
  @mail = MailSelf.new  

end


puts



def websocket
  @websocket = WebSoket.new @motor, @hareket, $var, @yangin
  @websocket.start
end


def mailService
  Thread.new do
    loop do

    end
  end
end



setup
mailService


@bashself.kamera 'dosya_olustur'

websocket
# @mail.mail 'sistem_baslatildi'
# @mail.mail 'hareket_algilandi'

# @bashself.kamera 'resim_cek'

# Baslangic Smsi
# $board.uno_sms 1



Thread.new do
  loop do
    $var.print_uzaklik
    sleep 0.1
  end
end

loop do
  if $var.mailAt
    @mail.mail 'hareket_algilandi'
    sleep 1000
  end
end





END{
  $board.close
  @websocket.exit
}
