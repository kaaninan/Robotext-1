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
        {10 => 'led_1'} => 1,
        {11 => 'led_2'} => 1,
        {12 => 'transistor_1'} => 1,
        {13 => 'transistor_2'} => 1,


        {0 => 'motor_sag_on_enkoder'} => 0,
        {1 => 'motor_sag_arka_enkoder'} => 0,
        {2 => 'motor_sol_on_enkoder'} => 0,
        {3 => 'motor_sol_arka_enkoder'} => 0,
        {4 => 'yakinlik_yer'} => 0
    }

  end



  def getPins
    return @arduino_uno_pin
  end


  def pin_ara pin_ismi
    @arduino_uno_pin.each do |a,b|
      a.each do |a,b|
        if b == pin_ismi
          return a
        end
      end
    end
  end


end
