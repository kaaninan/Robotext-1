require 'net/smtp'
require 'pony'

Pony.mail({
    :to => 'kaaninan@outlook.com',
    :subject => 'Hi',
    :html_body => '<b>KAAN</b>INAN',
    :attachments => {"merhaba.jpg" => File.read("test.jpg"), "merhaba2.jpg" => File.read("test2.jpg")},
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

Pony.mail(:to => 'you@example.com', :from => 'me@example.com', :subject => 'hi', :body => 'Hello there.')