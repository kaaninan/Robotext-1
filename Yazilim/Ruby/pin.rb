class Pin

  ## 0  -> ANALOG
  ## 1  -> OUTPUT
  ## 2  -> INPUT
  ## 3  -> SERVO

  $arduino_mega = {
      {2 => 'motor_sol_on'} => 1,
      {3 => 'motor_sol_arka'} => 1,
      {4 => 'motor_sag_on'} => 1,
      {5 => 'motor_sag_arka'} => 1,
      {6 => 'servo_x'} => 3,
      {7 => 'servo_y'} => 3,
      {8 => 'hareket_on_sag'} => 2,
      {9 => 'hareket_on_sol'} => 2,
      {10 => 'hareket_arka_sag'} => 2,
      {11 => 'hareket_arka_sol'} => 2,
      {12 => 'ses_sensoru'} => 2,

      {22 => 'motor_sol_on_yon'} => 1,
      {23 => 'motor_sol_arka_yon'} => 1,
      {24 => 'motor_sag_on_yon'} => 1,
      {25 => 'motor_sag_arka_yon'} => 1,
      {26 => 'buzzer_1'} => 1,
      {27 => 'buzzer_2'} => 1,
      {28 => 'ekran_sag_isik'} => 1,
      {29 => 'ekran_sol_isik'} => 1,

      {42 => 'uzaklik_on_alt_1'} => 2,
      {43 => 'uzaklik_on_alt_2'} => 2,
      {44 => 'uzaklik_on_ust_1'} => 2,
      {45 => 'uzaklik_on_ust_2'} => 2,
      {46 => 'uzaklik_arka_1'} => 2,
      {47 => 'uzaklik_arka_2'} => 2,

      {0 => 'motor_sol_on_hiz'} => 0,
      {1 => 'motor_sol_arka_hiz'} => 0,
      {2 => 'motor_sag_on_hiz'} => 0,
      {3 => 'motor_sag_arka_hiz'} => 0,
      {4 => 'uzaklik_sag_on'} => 0,
      {5 => 'uzaklik_sag_arka'} => 0,
      {6 => 'uzaklik_sol_on'} => 0,
      {7 => 'uzaklik_sol_arka'} => 0,
      {8 => 'sicaklik_sensoru'} => 0,
      {9 => 'gaz_sensoru'} => 0,
      {10 => 'ldr_on_sag'} => 0,
      {11 => 'ldr_on_sol'} => 0,
      {12 => 'ldr_arka'} => 0,
  }


  def megaPin
    return $arduino_mega
  end


  def pin_ara pin_ismi
    $arduino_mega.each do |a,b|
      a.each do |x,y|
        if y == pin_ismi
          return x
        end
      end
    end
  end


end