class BashSelf

  def initialize

    # Kayıtlı Resimlerin Isimleri
    @array = Array.new
  end

  def ses gelen
    Thread.new do

      if gelen == 'acildi'
        `omxplayer /home/pi/Robotext/Ses/Robotext_Acildi.mp3`
      elsif gelen == 'hareket_algilandi'
        `omxplayer /home/pi/Robotext/Ses/Hareket_Algilandim.mp3`
      elsif gelen == 'hareket_baslatildi'
        `omxplayer /home/pi/Robotext/Ses/Hareket_Algilama_Baslatildi.mp3`
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
        bash = `$HOME/kamera.sh`
        bash.each_line do |i|
          @array.push i.to_s.chomp
        end
        puts
        puts "BASH RESIM CEK"
        puts


      elsif komut == 'resim_bul'
        bash = `ls /home/pi/temp_guvenlik/*`
        bash.each_line do |i|
          @array.push i.to_s.chomp
        end

      elsif komut == 'dosya_olustur'
        puts 'Dosya Olustur'
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