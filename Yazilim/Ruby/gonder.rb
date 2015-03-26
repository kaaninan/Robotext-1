$LOAD_PATH << '.'
require 'pin'

class Gonder


	def initialize board
		@board = board
		@sensor = board.getSensor

    # @servo_x = 80
    @servo_x = 0
    # @servo_y = 10
    @servo_y = 180
	end



  # THREAD

  def servo_thread
    @thr_servo = Thread.new do
      loop do
        @board.mega_serial_gonder 'servo_x', @servo_x
        @board.mega_serial_gonder 'servo_y', @servo_y
        sleep 1
      end
    end
  end


  def servo_thread_stop
    @thr_servo.exit
  end

	def servo yon

  	@servo_y = 10

		if yon == 'sag'
			@servo_x = 20
		elsif yon == 'sol'
      @servo_x = 160
		else
      @servo_x = 80
		end
	end

	def servo_selam
    sleep 0.5
		@servo_y = 10
		sleep 1.5
    @servo_y = 120
		sleep 0.5
    @servo_y = 10
	end



	def buzzer deger

		if deger == 'cal'
			@board.mega_serial_gonder 'buzzer', 1
		elsif deger == 'sus'
			@board.mega_serial_gonder 'buzzer', 0
		elsif deger == 'bip'
			@bip = Thread.new do
				loop do
					@board.mega_serial_gonder 'buzzer', 1
					sleep 0.5
					@board.mega_serial_gonder 'buzzer', 0
					sleep 0.5
				end
			end
		elsif deger == 'acilis'
			Thread.new do
				@board.mega_serial_gonder 'buzzer', 1
				sleep 1
				@board.mega_serial_gonder 'buzzer', 0
				sleep 0.5
				@board.mega_serial_gonder 'buzzer', 1
				sleep 0.5
				@board.mega_serial_gonder 'buzzer', 0
			end
		else
			@bip.exit
		end
	end


	def ekran deger
		# Cumle indexi
		@board.mega_serial_gonder 'ekran', deger
	end


	def ekran_isik deger
		if deger == 'kirp'
			Thread.new do
				2.times do
					@board.mega_serial_gonder 'ekran_isik', 0
					sleep 0.4
					@board.mega_serial_gonder 'ekran_isik', 1
					sleep 0.4
				end
			end
		elsif deger == 'yak'
			@board.mega_serial_gonder 'ekran_isik', 1
		elsif deger == 'sondur'
			@board.mega_serial_gonder 'ekran_isik', 0
		end
	end


	def led komut
		if komut == 'basla'
			@thr = Thread.new do
				loop do
					@board.mega_serial_gonder 'led_1', 1
					@board.mega_serial_gonder 'led_2', 0
					sleep 1
					@board.mega_serial_gonder 'led_1', 0
					@board.mega_serial_gonder 'led_2', 1
					sleep 1
				end
			end
		elsif komut == 'durdur'
			@thr.exit
		end
	end


	# VERI ISTE
	def gonder_mega
		Thread.new do
			loop do
				@board.mega_serial_gonder 'sensorler', nil
				sleep 0.01
			end
		end
	end

end