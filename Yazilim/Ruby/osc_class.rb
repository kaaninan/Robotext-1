require 'osc'

class OpenS

  @liste = [
      "",
      "",
  ]

  def initialize
    OSC.using(:input_port => 7000) do

      receive("/Motor/Sol") { |val| p "#{i} -> #{val}" }
      p "OSC Hazir, PORT: #{input_ports.join(', ')}"
      wait_for_input

    end
  end

end