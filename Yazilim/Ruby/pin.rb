class Pin

  ## 0  -> ANALOG
  ## 1  -> OUTPUT
  ## 2  -> INPUT
  ## 3  -> SERVO


  def initialize
    @arduino_uno_pin = {
      {2 => 'motor_sag_on_yon'} => 1,
      {3 => 'motor_sag_on_hiz'} => 1,
      {4 => 'motor_sag_arka_yon'} => 1,
      {5 => 'motor_sag_arka_hiz'} => 1,
      {6 => 'motor_sol_on_hiz'} => 1,
      {7 => 'motor_sol_on_yon'} => 1,
      {8 => 'motor_sol_arka_yon'} => 1,
      {9 => 'motor_sol_arka_hiz'} => 1,

      {0 => 'motor_sag_on_enkoder'} => 0,
      {1 => 'motor_sag_arka_enkoder'} => 0,
      {2 => 'motor_sol_on_enkoder'} => 0,
      {3 => 'motor_sol_arka_enkoder'} => 0
    }

    @arduino_mega_pin = {
      {22 => 'hareket_sag'} => 2,
      {23 => 'hareket_sol'} => 2,
      {24 => 'buzzer_1'} => 1,
      {25 => 'buzzer_1'} => 1,
      {26 => 'ses'} => 2,
      {27 => 'ekran_isik'} => 1,
      {36 => 'trig_sag'} => 1,
      {37 => 'echo_sag'} => 2,
      {38 => 'trig_sag'} => 1,
      {39 => 'echo_sag'} => 2,

      {0 => 'sicaklik'} => 0,
      {1 => 'ldr'} => 0
    }

  end



  def getPinUno
    return @arduino_uno_pin
  end

  def getPinMega
    return @arduino_mega_pin
  end


  def pin_ara_uno pin_ismi
    @arduino_uno_pin.each do |a,b|
      a.each do |a,b|
        if b == pin_ismi
          return a
        end
      end
    end
  end


  def pin_ara_mega pin_ismi
    @arduino_mega_pin.each do |a,b|
      a.each do |a,b|
        if b == pin_ismi
          return a
        end
      end
    end
  end


end