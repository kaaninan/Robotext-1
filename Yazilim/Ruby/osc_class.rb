require 'micro-osc'

class OpenS

  # OSC Input IDs
  $eski_liste = Array[
      'sol',
      'sag',
      'sol_ters',
      'sag_ters',
      'etkin_multitoggle/1/1',
      'etkin_multitoggle/1/2',
      'etkin_multitoggle/2/1',
      'etkin_multitoggle/2/2',
      'buzzer',
      'servo_1',
      'servo_2'
  ]

  $osc_liste = Hash.new

  def initialize board, gonder, motor

    @board = board
    @gonder = gonder
    @motor = motor

    # OSC ID Listesi Oluşturma
    $eski_liste.each do |i|
      item = Hash['/Main/'+i => 0]
      $osc_liste.merge!(item)
    end

  end

  def start
    OSC.using(:input_port => 8000) do
      $osc_liste.each do |a, b|
        receive(a) do |val|

          # LOG
          # puts "#{a} -> #{val.to_i}"

          $osc_liste[a] = val.to_i
        end
      end
      p "OSC Hazir, Port: #{input_ports.join(', ')}"
      wait_for_input
    end
  end




  def motor_start
    @thr = Thread.new do
      loop do
        @motor.motor_osc $osc_liste['/Motor/sag'], $osc_liste['/Motor/sol'], $osc_liste['/Motor/sag_ters'], $osc_liste['/Motor/sol_ters']

        if $osc_liste['buzzer'] == 1
          @board.buzzer 'cal'
        else
          @board.buzzer 'sus'
        end

        sleep 0.1
      end
    end
  end

  def motor_stop
    @thr.exit
  end



  def servo_start
    @thr2 = Thread.new do
      loop do
        @gonder.servo_osc $osc_liste['/Main/servo_1'], $osc_liste['/Main/servo_2']
        sleep 0.1
      end
    end
  end

  def servo_stop
    @thr2.exit
    @gonder.servo_yon 'orta'
  end

  def get_liste
    return $osc_liste
  end

end