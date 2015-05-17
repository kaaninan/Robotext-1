$LOAD_PATH << '.'
require 'pin'
require 'connect'

class Gonder


	def initialize board
		@board = board
	end


	def servo yon
  	# @board.deger_servo_y = 10

		if yon == 'sag'
			@board.deger_servo_x = 150
		elsif yon == 'sol'
      @board.deger_servo_x = 30
		else
      @board.deger_servo_x = 80
		end
	end


	def buzzer deger

		if deger == 1
			@board.deger_buzzer = 1
		elsif deger == 0
      @board.deger_buzzer = 0
		elsif deger == 2
			@bip = Thread.new do
				loop do
          @board.deger_buzzer = 1
					sleep 0.5
          @board.deger_buzzer = 0
					sleep 0.5
				end
      end

    elsif deger == 3
      @bip.exit
      @board.deger_buzzer = 0

		elsif deger == 4
			Thread.new do
        @board.deger_buzzer = 1
				sleep 0.3
        @board.deger_buzzer = 0
				sleep 0.3
      end
    end
	end


	def ekran_isik deger
		if deger == 2

			Thread.new do
				3.times do
          @board.deger_ekran_isik = 0
					sleep 0.3
          @board.deger_ekran_isik = 1
					sleep 0.3
				end
      end

		elsif deger == 1
      @board.deger_ekran_isik = 1

		elsif deger == 0
      @board.deger_ekran_isik = 0
		end
	end


	def led komut

		if komut == 2
			@thr = Thread.new do
				loop do
          @board.deger_led_1 = 1
          @board.deger_led_2 = 0
					sleep 1
          @board.deger_led_1 = 0
          @board.deger_led_2 = 1
					sleep 1
				end
      end

		elsif komut == 3
			@thr.exit

    elsif komut == 1
      @board.deger_led_1 = 1
      @board.deger_led_2 = 1

    elsif komut == 0
      @board.deger_led_1 = 0
      @board.deger_led_2 = 0

		end
	end


end