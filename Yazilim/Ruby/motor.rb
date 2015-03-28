$LOAD_PATH << '.'
require 'pin'
require 'gonder'

class Motor


  def initialize board, gonder
    @gonder = gonder

    @arduino_uno = board.getUno
    @sensor = board.getSensor
    @board = board


    puts '==> Motorlar Etkinlestirildi <=='

    # EKRANA MANUEL MOD YAZ
    @gonder.ekran = 6
    sleep 0.4
    @gonder.ekran = 4


    ## ARDUINO UNO PINLERI BELIRLE
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


    ## OTOMATIK MOD DEGISKENLERI
    @durum_on = false
    @durum_arka = false
    @durum_sag = false
    @durum_sol = false

    @sinir_on = 10
    @sinir_arka = 10
    @sinir_sag = 10
    @sinir_sol = 10


    # OTOMATIK MOD THREAD'LARIN KONTROLU
    @thread_motor = true
    @thread_uzaklik = true
  end




  # KOMUT
  def motor_auto_start

    if @hareket.getEtkin == true

      Thread.new do
        s = Stopwatch.new
        motor_auto_basla
        running = false

        loop do
          saat = s.elapsed_time
          if saat%10 == 0
            if running == true
              motor_auto_stop
              sleep 2
              @hareket.start
              running = false
            else
              @hareket.stop
              sleep 2
              motor_auto_start
              running = true
            end
          end
          sleep 0.1
        end

      end

    else
      motor_auto_basla
    end

  end

  def motor_auto_basla
    puts '==> OTOMATIK MOD ETKIN <=='
    @motor_auto_thread = Thread.new do
      sleep 1
      while @thread_motor
        motor_auto_komut
        sleep 0.1
      end
    end

    @uzaklik_thread = Thread.new do
      while @thread_uzaklik
        uzaklik_kontrol
        sleep 0.1
      end
    end
  end


  def motor_auto_stop
    puts '==> OTOMATIK MOD KAPALI <=='
    @thread_motor = false
    @thread_uzaklik = false
    motor_dur
  end


# OTOMATİK MOD KONTROL (NO LOOP)

  private

  def motor_auto_komut

    if @durum_on == true

      if @durum_sag == true && @durum_sol == true
        motor_ileri

      elsif @durum_sag == false && @durum_sol == true
        motor_ileri_sol

      elsif @durum_sag == true && @durum_sol == false
        motor_ileri_sag

      else
        motor_ileri
      end

    else

      if @durum_sag == true
        motor_sag
        sleep 1.5

      elsif @durum_sol == true
        motor_sol
        sleep 1.5

      else
        motor_geri
        sleep 2

      end

    end

  end

  def uzaklik_kontrol

    puts "Durum On: #{@durum_on}  Arka #{@durum_arka}  Sag #{@durum_sag}  Sol #{@durum_sol}"

    @sensor_on = @sensor.uzaklik_on.dup
    @sensor_arka = @sensor.uzaklik_arka.dup
    @sensor_sag = @sensor.uzaklik_sag.dup
    @sensor_sol = @sensor.uzaklik_sol.dup

    if @sensor_on > @sinir_on
      @durum_on = true
    else
      @durum_on = false
    end

    if @sensor_arka > @sinir_arka
      @durum_arka = true
    else
      @durum_arka = false
    end

    if @sensor_sag > @sinir_sag
      @durum_sag = true
    else
      @durum_sag = false
    end

    if @sensor_sol > @sinir_sol
      @durum_sol = true
    else
      @durum_sol = false
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

  def motor_sol
    @arduino_uno.digital_write @y_sag_on, 1
    @arduino_uno.digital_write @y_sag_arka, 0
    @arduino_uno.digital_write @y_sol_on, 0
    @arduino_uno.digital_write @y_sol_arka, 1

    @arduino_uno.analog_write @h_sag_on, 255
    @arduino_uno.analog_write @h_sag_arka, 255
    @arduino_uno.analog_write @h_sol_on, 255
    @arduino_uno.analog_write @h_sol_arka, 255
  end

  def motor_sag
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



  def setGuvenlik hareket
    @hareket = hareket
  end

  def get_otomatik
    return @thread_motor
  end


  # TEST
  # def motor_osc sag_hiz, sol_hiz, sag_ters, sol_ters
  #
  #   if sag_ters == 1
  #     yon_sag1 = 0
  #     yon_sag2 = 1
  #   else
  #     yon_sag1 = 1
  #     yon_sag2 = 0
  #   end
  #
  #   if sol_ters == 1
  #     yon_sol1 = 0
  #     yon_sol2 = 1
  #   else
  #     yon_sol1 = 1
  #     yon_sol2 = 0
  #   end
  #
  #   @arduino_uno.digital_write @h_sag_on, sag_hiz
  #   @arduino_uno.digital_write @h_sag_arka, sag_hiz
  #   @arduino_uno.digital_write @h_sol_on, sol_hiz
  #   @arduino_uno.digital_write @h_sol_arka, sol_hiz
  #
  #   @arduino_uno.analog_write @y_sag_on, yon_sag1
  #   @arduino_uno.analog_write @y_sag_arka, yon_sag2
  #   @arduino_uno.analog_write @y_sol_on, yon_sol1
  #   @arduino_uno.analog_write @y_sol_arka, yon_sol2
  #
  # end

end


class Stopwatch

  def initialize()
    @start = Time.now
  end

  def elapsed_time
    now = Time.now
    elapsed = now - @start
    return elapsed.to_i
  end

end