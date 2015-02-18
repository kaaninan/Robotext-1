require 'osc'
require 'pp'

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

  def initialize

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
          puts "#{b} -> #{val}"
          $osc_liste[a] = val
        end
      end
      p "OSC Hazir, Port: #{input_ports.join(', ')}"
      wait_for_input
    end
  end


  def getListe
    return $osc_liste
  end

end