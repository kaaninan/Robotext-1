$LOAD_PATH << '.'
require 'pin'

class Motor


  def initialize board

    @arduino_uno = board.getUno
    @board = board
    @sensor = board.getSensor

    puts '==> Motorlar Etkinlestirildi <=='

    pin = Pin.new

    @h_sag_on = pin.pin_ara 'motor_sag_on_hiz'
    @h_sag_arka = pin.pin_ara 'motor_sag_arka_hiz'
    @h_sol_on = pin.pin_ara 'motor_sol_on_hiz'
    @h_sol_arka = pin.pin_ara 'motor_sol_arka_hiz'

    @y_sag_on = pin.pin_ara 'motor_sag_on_yon'
    @y_sag_arka = pin.pin_ara 'motor_sag_arka_yon'
    @y_sol_on = pin.pin_ara 'motor_sol_on_yon'
    @y_sol_arka = pin.pin_ara 'motor_sol_arka_yon'

    @e_sag_on = pin.pin_ara 'motor_sag_on_enkoder'
    @e_sag_arka = pin.pin_ara 'motor_sag_arka_enkoder'
    @e_sol_on = pin.pin_ara 'motor_sol_on_enkoder'
    @e_sol_arka = pin.pin_ara 'motor_sol_arka_enkoder'

    @on_dikey = false
    @on_sag_dikey = false
    @on_sol_dikey = false

    @on_sag_capraz = false
    @on_sol_capraz = false

    @sag_dikey = false
    @sag_capraz = false

    @sol_dikey = false
    @sol_capraz = false

    @sag_ort_uygun = false
    @sol_ort_uygun = false

    @sinir = 10 # Ultrasonik
    @yakinlik_sinir = 100 # TCRT 5000
    @yan_sinir = 10 # Sharp
    @ortalama_sinir = 10 # Sharp Yan Ortalama Sınır

  end


  def motor_klavye_tus
    Thread.new do
      loop do
        motor_kontrol_tus
      end
    end
  end

  def motor_auto_start
    @motor_auto_thread = Thread.new do
      loop do
        motor_auto_komut
      end
    end

    @uzaklik_thread = Thread.new do
      loop do
        uzaklik_kontrol
      end
    end
  end

  def motor_auto_stop
    @motor_auto_thread.exit
    @uzaklik_thread.exit
    motor_dur
  end



# OTOMATİK MOD KONTROL (NO LOOP)

  private

  def motor_auto_komut

    if @on_dikey == true # ON TARAF BOŞSA

      if @on_sag_capraz == true && @on_sol_capraz == true # ÇAPRAZINDA ENGEL YOK

        if @sag_dikey == true && @sol_dikey == true

          ## YOL BOŞ
          motor_ileri

        ## SAĞ VEYA SOL DİKEY TARAFTA ENGEL VAR
        elsif @sag_dikey == true && @sol_dikey == false

          # SOL TARAFTA ENGEL VAR
          # SAGA DOĞRU GİT
          motor_ileri_sag

        elsif @sag_dikey == false && @sol_dikey == true

          # SAĞ TARAFTA ENGEL VAR
          # SOLA DOĞRU GİT
          motor_ileri_sol
        end


      elsif @on_sag_capraz == false && @on_sol_capraz == true

        ## SAG CAPRAZDA ENGEL VAR
        ## SOLA DOĞRU DÖN

        motor_geri
        sleep 1
        motor_sol


      elsif @on_sol_capraz == false && @on_sag_capraz == true

        ## SOL ÇAPRAZDA ENGEL VAR
        ## SAĞA DOĞRU DÖN

        motor_geri
        sleep 1
        motor_sag

      else

        ## ÇAPRAZ KAPALI
        ## GERİ DÖN

        motor_geri
        sleep 1

        # TODO rastgele dönme ekle

      end


    else
      ## ON TARAFTA ENGEL VAR
      # Sağ Tarafa Bak

      
      if @on_sag_dikey == true && @on_sol_dikey == false

        if @sag_dikey == true

          if @on_sag_capraz == true && @on_sol_capraz == true
            motor_sag
          
          else
            motor_geri
            sleep 1
          end

        elsif @sol_dikey == true

          if @on_sag_capraz == true && @on_sol_capraz == true
            motor_sol
          
          else
            motor_geri
            sleep 1
          end

        else
          motor_geri
          sleep 1

      elsif @on_sag_dikey == false && @on_sol_dikey == true

        if @sol_dikey == true

          if @on_sag_capraz == true && @on_sol_capraz == true
            motor_sol
          
          else
            motor_geri
            sleep 1
          end

        elsif @sag_dikey == true

          if @on_sag_capraz == true && @on_sol_capraz == true
            motor_sag
          
          else
            motor_geri
            sleep 1
          end

        else
          motor_geri
          sleep 1


      elsif @on_sag_dikey == false && @on_sol_dikey == false

    
        if @sag_dikey == true && @sol_dikey == false

          if @sag_capraz == true

            # SAGA DON
            motor_sag

          else

            ## ÇAPRAZDA ENGEL VAR
            motor_geri
            sleep 1

          end


        elsif @sol_dikey == true && @sag_dikey == false

          if @sol_capraz == true

            # SOLA DÖN
            motor_sol

          else

            # ÇAPRAZDA ENGEL VAR
            motor_geri
            sleep 1

          end

        elsif @sol_dikey == false && @sag_dikey == false

          ## İKİ TARAFTADA ENGEL VAR
          motor_geri
          sleep 1



        else

          ## SAĞ VE SOL TARAF BOŞ

          # RASTEGELE OLARAK BİR TARAFA DON
            a = rand 2

          if a == 1
            motor_sag
          else
            motor_sol
          end

        end
      end
    end
  end

  def uzaklik_kontrol

    # print @on_dikey
    # print ' '
    # print @on_sag_capraz
    # print ' '
    # print @on_sol_capraz
    # print ' '
    # print @sag_dikey
    # print ' '
    # print @sag_capraz
    # print ' '
    # print @sol_dikey
    # print ' '
    # print @sol_capraz
    # print ' '
    # print @sag_ort_uygun
    # print ' '
    # puts @sol_ort_uygun


    ## ON TARAF ### ULTRASONIC

    if @sensor.uzaklik_on_sag.to_i > @sinir && @sensor.uzaklik_on_sol.to_i > @sinir
      @on_dikey = true
    else
      @on_dikey = false
    end

    if @sensor.uzaklik_on_sag.to_i > @sinir
      @on_sag_dikey = true
    else
      @on_sag_dikey = false
    end

    if @sensor.uzaklik_on_sol.to_i > @sinir
      @on_sol_dikey = true
    else
      @on_sol_dikey = false
    end


    ## ON CAPRAZ ### TCRT 5000

    if @sensor.yakinlik_on_sag.to_i < @yakinlik_sinir
      @on_sag_capraz = false
    else
      @on_sag_capraz = true
    end

    if @sensor.yakinlik_on_sol.to_i < @yakinlik_sinir
      @on_sol_capraz = false
    else
      @on_sol_capraz = true
    end



    ### YAN TARAF ### SHARP

    # SAĞA BAK
    if @sensor.uzaklik_sag_on.to_i > @yan_sinir && @sensor.uzaklik_sag_arka.to_i > @yan_sinir
      # DİKEY OLARAK BOŞ
      @sag_dikey = true
    else
      # DİKEY ENGEL VAR
      @sag_dikey = false
    end


    # SOLA BAK
    if @sensor.uzaklik_sol_on.to_i > @yan_sinir && @sensor.uzaklik_sol_arka.to_i > @yan_sinir
      # DİKEY OLARAK BOŞ
      @sol_dikey = true
    else
      # DİKEY ENGEL VAR
      @sol_dikey = false
    end



    # EĞER SAĞ VE SOL SINIRDAN KÜÇÜKSE KARŞILAŞTIR

    if @sag_dikey == false && @sol_dikey == false

      ## ORTALAMALARINI AL
      sag_ort = (@sensor.uzaklik_sag_on.to_i + @sensor.uzaklik_sag_arka.to_i) / 2
      sol_ort = (@sensor.uzaklik_sol_on.to_i + @sensor.uzaklik_sol_arka.to_i) / 2

      # EĞER ORTALAMALAR SINIRIN ALTINDA DEĞİLSE UYGUN YÖNÜ SEÇ
      if sag_ort > @ortalama_sinir && sol_ort > @ortalama_sinir

        if sag_ort > sol_ort

          # SAĞ TARAF SOLA GÖRE BOŞ
          @sag_ort_uygun = true
          @sol_ort_uygun = false

        else

          # SOL TARAF SAĞA GÖRE BOŞ
          @sol_ort_uygun = true
          @sag_ort_uygun = false

        end

      else
        @sag_ort_uygun = false
        @sol_ort_uygun = false

      end
    end
  end

  def motor_kontrol_tus
  
    a = gets.chomp

    if a == 'w'
      @motor.motor_ileri
    elsif a == 's'
      @motor.motor_geri
    elsif a == 'a'
      @motor.motor_sol
    elsif a == 'd'
      @motor.motor_sag
    elsif a == 'q'
      @motor.motor_ileri_sol
    elsif a == 'e'
      @motor.motor_ileri_sag
    elsif a == 'z'
      @motor.motor_dur
    end
  end



# MANUEL KOMUTLAR

  public

  def motor_ileri
    @arduino_uno.digital_write @y_sag_on, 0
    @arduino_uno.digital_write @y_sag_arka, 1
    @arduino_uno.digital_write @y_sol_on, 0
    @arduino_uno.digital_write @y_sol_arka, 1

    @arduino_uno.analog_write @h_sag_on, 255
    @arduino_uno.analog_write @h_sag_arka, 255
    @arduino_uno.analog_write @h_sol_on, 255
    @arduino_uno.analog_write @h_sol_arka, 255
  end

  def motor_geri
    @arduino_uno.digital_write @y_sag_on, 1
    @arduino_uno.digital_write @y_sag_arka, 0
    @arduino_uno.digital_write @y_sol_on, 1
    @arduino_uno.digital_write @y_sol_arka, 0

    @arduino_uno.analog_write @h_sag_on, 255
    @arduino_uno.analog_write @h_sag_arka, 255
    @arduino_uno.analog_write @h_sol_on, 255
    @arduino_uno.analog_write @h_sol_arka, 255
  end

  def motor_sag
    @arduino_uno.digital_write @y_sag_on, 1
    @arduino_uno.digital_write @y_sag_arka, 0
    @arduino_uno.digital_write @y_sol_on, 0
    @arduino_uno.digital_write @y_sol_arka, 1

    @arduino_uno.analog_write @h_sag_on, 255
    @arduino_uno.analog_write @h_sag_arka, 255
    @arduino_uno.analog_write @h_sol_on, 255
    @arduino_uno.analog_write @h_sol_arka, 255
  end

  def motor_sol
    @arduino_uno.digital_write @y_sag_on, 0
    @arduino_uno.digital_write @y_sag_arka, 1
    @arduino_uno.digital_write @y_sol_on, 1
    @arduino_uno.digital_write @y_sol_arka, 0

    @arduino_uno.analog_write @h_sag_on, 255
    @arduino_uno.analog_write @h_sag_arka, 255
    @arduino_uno.analog_write @h_sol_on, 255
    @arduino_uno.analog_write @h_sol_arka, 255
  end

  def motor_ileri_sag
    @arduino_uno.digital_write @y_sag_on, 0
    @arduino_uno.digital_write @y_sag_arka, 1
    @arduino_uno.digital_write @y_sol_on, 0
    @arduino_uno.digital_write @y_sol_arka, 1

    @arduino_uno.analog_write @h_sag_on, 0
    @arduino_uno.analog_write @h_sag_arka, 0
    @arduino_uno.analog_write @h_sol_on, 255
    @arduino_uno.analog_write @h_sol_arka, 255
  end

  def motor_ileri_sol
    @arduino_uno.digital_write @y_sag_on, 0
    @arduino_uno.digital_write @y_sag_arka, 1
    @arduino_uno.digital_write @y_sol_on, 0
    @arduino_uno.digital_write @y_sol_arka, 1

    @arduino_uno.analog_write @h_sag_on, 255
    @arduino_uno.analog_write @h_sag_arka, 255
    @arduino_uno.analog_write @h_sol_on, 0
    @arduino_uno.analog_write @h_sol_arka, 0
  end

  def motor_dur
    @arduino_uno.digital_write @y_sag_on, 0
    @arduino_uno.digital_write @y_sag_arka, 1
    @arduino_uno.digital_write @y_sol_on, 0
    @arduino_uno.digital_write @y_sol_arka, 1

    @arduino_uno.analog_write @h_sag_on, 0
    @arduino_uno.analog_write @h_sag_arka, 0
    @arduino_uno.analog_write @h_sol_on, 0
    @arduino_uno.analog_write @h_sol_arka, 0
  end

end