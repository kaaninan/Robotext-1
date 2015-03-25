class Bash

  def initialize

    # Kayıtlı Resimlerin Isimleri
    @array = Array.new
  end

  def ses gelen
    Thread.new do

      if gelen == 'merhaba'
        komut = `omxplayer /home/pi/merhaba.mp3`
      elsif gelen == 'hareket_algilandi'
      elsif gelen == 'hareket_baslatildi'
      elsif gelen == 'otomatik_mod_basla'
      elsif gelen == 'otomatik_mod_son'
      elsif gelen == 'otomatik_mod_baslatildi'
      elsif gelen == 'otomatik_mod_baslatildi'
      elsif gelen == 'kullanici_baglandi'
      elsif gelen == 'baslatiliyor'
      elsif gelen == 'anlat'

      end
    end
  end



  def kamera komut

    Thread.new do

      if komut == 'resim_cek'
        bash = `./home/pi/Robotext/Yazilim/Bash/kamera.sh`
        puts
        puts "BASH RESIM CEK \n #{bash}"
        puts


      elsif komut == 'resim_bul'
        bash = `ls /Users/Kaaninan/Robotext/Yazilim/Resim/*`
        bash.each_line do |i|
          @array.push i.to_s.chomp
        end

      elsif komut == 'dosya_olustur'
        time = Time.new
        tarih = "#{time.day}:#{time.month}:#{time.year}__#{time.hour}.#{time.min}"
        bash = `mkdir /home/pi/guvenlik/#{tarih}`
        bash = `mv /home/pi/temp_guvenlik/* /home/pi/guvenlik/#{tarih}`
      end
   end

  end


  def get_resim_listesi
    return @array
  end

end

bash = Bash.new

bash.ses 'merhaba'

gets