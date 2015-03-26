class BashSelf

  def initialize

    # Kayıtlı Resimlerin Isimleri
    @array = Array.new
  end

  def ses gelen
    Thread.new do

      if gelen == 'merhaba'
        `omxplayer /home/pi/Robotext/Ses/merhaba.mp3`
      elsif gelen == 'hareket_algilandi'
        `omxplayer /home/pi/Robotext/Ses/hareket.mp3`
      elsif gelen == 'hareket_baslatildi'
        `omxplayer /home/pi/Robotext/Ses/hareket_basla.mp3`
      elsif gelen == 'otomatik_mod_basla'
      elsif gelen == 'otomatik_mod_son'
      elsif gelen == 'otomatik_mod_baslatildi'
      elsif gelen == 'otomatik_mod_baslatildi'
      elsif gelen == 'kullanici_baglandi'
      elsif gelen == 'baslatiliyor'
        `omxplayer /home/pi/Robotext/Ses/merhaba.mp3`
      elsif gelen == 'anlat'
      elsif gelen == 'siren'
        `omxplayer /home/pi/Robotext/Ses/siren1.mp3`
      end
    end
  end



  def kamera komut

      if komut == 'resim_cek'
        puts 'GELDI'
        bash = `cd /home/pi/Robotext/Yazilim/Bash/`
        bash2 = `./kamera.sh`
        puts
        puts "BASH RESIM CEK \n #{bash} #{bash2}"
        puts


      elsif komut == 'resim_bul'
        bash = `ls /Users/Kaaninan/Robotext/Yazilim/Resim/*`
        bash.each_line do |i|
          @array.push i.to_s.chomp
        end

      elsif komut == 'dosya_olustur'
        time = Time.new
        tarih = "#{time.day}:#{time.month}:#{time.year}__#{time.hour}.#{time.min}"
        `mkdir /home/pi/guvenlik/#{tarih}`
        `mv /home/pi/temp_guvenlik/* /home/pi/guvenlik/#{tarih}`
      end

  end


  def get_resim_listesi
    return @array
  end

end