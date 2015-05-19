class Var

  # Kartların Durumu
  attr_accessor :bagli_mega, :bagli_uno
  
  # Arduino Mega Gonderilecek Degerler
  attr_accessor :m_serial # Serial Alışverişi Aç (if == true)
  attr_accessor :m_buzzer, :m_ekran_isik, :m_ekran, :m_servox, :m_servoy

  # Sensor

  # MEGA
  attr_accessor :hareket_sag, :hareket_sol, :ses, :isik, :gaz, :uzaklik_on_sag, :uzaklik_on_sol, :sicaklik

  # UNO
  attr_accessor :motor_sag_on_enkoder, :motor_sag_arka_enkoder, :motor_sol_on_enkoder, :motor_sol_arka_enkoder



  def print_uzaklik
    puts "Sag On: #{@uzaklik_on_sag}  Sol On: #{@uzaklik_on_sol}"
  end

  def print_sensor
    puts "Isik #{@isik}   Hareket #{@hareket_sag} #{@hareket_sol}   Ses #{@ses}  Sicaklik #{@sicaklik}  Gaz #{@gaz}"
  end

  def print_enkoder
    puts "#{@motor_sag_on_enkoder} - #{@motor_sag_arka_enkoder} - #{@motor_sol_on_enkoder} - #{@motor_sol_arka_enkoder}"
  end




  # Degerleri Kolay Degistirmes

  def servo yon
    if yon == 'sag'
	  @m_servox = 150
	elsif yon == 'sol'
      @m_servox = 30
	else
      @m_servox = 80
	end
  end


  def buzzer deger
	if deger == 1
	  @m_buzzer = 1
	elsif deger == 0
      @m_buzzer = 0
	elsif deger == 2
	  @bip = Thread.new do
		loop do
		  @m_buzzer = 1
		  sleep 0.5
          @m_buzzer = 0
		  sleep 0.5
		end
	  end
    elsif deger == 3
      @bip.exit
      @m_buzzer = 0
  	elsif deger == 4
	  Thread.new do
        @m_buzzer = 1
		sleep 0.3
        @m_buzzer = 0
		sleep 0.3
      end
    end
  end


	def ekran_isik deger
	  if deger == 2
		Thread.new do
		  3.times do
            @m_ekran_isik = 0
			sleep 0.3
            @m_ekran_isik = 1
			sleep 0.3
		  end
      	end
      elsif deger == 1
      	@m_ekran_isik = 1
	  elsif deger == 0
        @m_ekran_isik = 0
	  end
	end

end