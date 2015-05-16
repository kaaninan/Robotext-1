require 'net/smtp'
require 'pony'
$LOAD_PATH << '.'
require 'bashself'

class MailSelf


  def mail secenek

    @bash = BashSelf.new

    Thread.new do

      if secenek == 'hareket_baslatildi'

        # resim1.jpg

        Pony.mail({
                      :to => 'kaaninan@outlook.com',
                      :subject => 'ROBOTEXT',
                      :attachments => {"resim1.jpg" => File.read('mail/logo.png'), "logo.png" => File.read("mail/logo.png")},
                      :html_body => File.read('/home/pi/Robotext/Yazilim/Ruby/mail/hareket_baslatildi.htm'),
                      :sender => 'Robotext',
                      :via => :smtp,
                      :via_options => {
                          :address        => 'smtp.gmail.com',
                          :port           => '587',
                          :user_name      => 'robotext.afl',
                          :password       => 'raspberry_12',
                          :authentication => :login, # :plain, :login, :cram_md5, no auth by default
                          :domain         => "Robotext" # the HELO domain provided by the client to the server
                      }
                  })





      elsif secenek == 'hareket_algilandi'

        sleep 2
        
        # resim1.jpg
        # resim2.jpg

        @bash.kamera 'resim_bul'

        sleep 1

        @array = @bash.get_resim_listesi


        puts 'Hareket Maili Gonderiliyor..'

        @sayi = @array.length

        Pony.mail({
                      :to => 'kaaninan@outlook.com',
                      :subject => 'ROBOTEXT',
                      :attachments => {"resim1.jpg" => File.read(@array[@sayi]), "logo.png" => File.read("mail/logo.png")},
                      :html_body => File.read("/home/pi/Robotext/Yazilim/Ruby/mail/hareket_algilandi.htm"),
                      :sender => 'Robotext',
                      :via => :smtp,
                      :via_options => {
                          :address        => 'smtp.gmail.com',
                          :port           => '587',
                          :user_name      => 'robotext.afl',
                          :password       => 'raspberry_12',
                          :authentication => :login, # :plain, :login, :cram_md5, no auth by default
                          :domain         => "Robotext" # the HELO domain provided by the client to the server
                      }
                  })

        puts 'Gonderildi ..'



      elsif secenek == 'sistem_baslatildi'

        puts 'Mail Gonderiliyor'

        Pony.mail({
                      :to => 'kaaninan@outlook.com',
                      :subject => 'ROBOTEXT',
                      :attachments => {"logo.png" => File.read("mail/logo.png")},
                      :html_body => File.read("/home/pi/Robotext/Yazilim/Ruby/mail/sistem_baslatildi.htm"),
                      :sender => 'Robotext',
                      :via => :smtp,
                      :via_options => {
                          :address        => 'smtp.gmail.com',
                          :port           => '587',
                          :user_name      => 'robotext.afl',
                          :password       => 'raspberry_12',
                          :authentication => :login, # :plain, :login, :cram_md5, no auth by default
                          :domain         => "Robotext" # the HELO domain provided by the client to the server
                      }
                  })

      end

    end


  end



end