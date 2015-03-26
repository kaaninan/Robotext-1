require 'net/smtp'
require 'pony'

class MailSelf


  def mail secenek, kime

    Thread.new do

      if secenek == 'hareket_baslatildi'

        # resim1.jpg

        Pony.mail({
                      :to => kime,
                      :subject => 'ROBOTEXT',
                      :attachments => {"resim1.jpg" => File.read('mail/logo.png'), "logo.png" => File.read("mail/logo.png")},
                      :html_body => File.read('mail/hareket_baslatildi.htm'),
                      :sender => 'Robotext',
                      :via => :smtp,
                      :via_options => {
                          :address        => 'smtp.gmail.com',
                          :port           => '25',
                          :user_name      => 'robotext.afl',
                          :password       => 'raspberry_12',
                          :authentication => :login, # :plain, :login, :cram_md5, no auth by default
                          :domain         => "Robotext" # the HELO domain provided by the client to the server
                      }
                  })





      elsif secenek == 'hareket_algilandi'

        # resim1.jpg
        # resim2.jpg

        Pony.mail({
                      :to => kime,
                      :subject => 'ROBOTEXT',
                      :attachments => {"resim1.jpg" => File.read("mail/logo.png"), "logo.png" => File.read("mail/logo.png")},
                      :html_body => File.read("mail/hareket_algilandi.htm"),
                      :sender => 'Robotext',
                      :via => :smtp,
                      :via_options => {
                          :address        => 'smtp.gmail.com',
                          :port           => '25',
                          :user_name      => 'robotext.afl',
                          :password       => 'raspberry_12',
                          :authentication => :login, # :plain, :login, :cram_md5, no auth by default
                          :domain         => "Robotext" # the HELO domain provided by the client to the server
                      }
                  })



      elsif secenek == 'sistem_baslatildi'

        Pony.mail({
                      :to => kime,
                      :subject => 'ROBOTEXT',
                      :attachments => {"logo.png" => File.read("mail/logo.png")},
                      :html_body => File.read("mail/sistem_baslatildi.htm"),
                      :sender => 'Robotext',
                      :via => :smtp,
                      :via_options => {
                          :address        => 'smtp.gmail.com',
                          :port           => '25',
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


mail = MailSelf.new
mail.mail 'sistem_baslatildi', 'kaaninan@outlook.com'
mail.mail 'hareket_baslatildi', 'kaaninan@outlook.com'
mail.mail 'hareket_algilandi', 'kaaninan@outlook.com'


gets