class Sensor

  # MEGA
  attr_accessor :uzaklik_sag_on, :uzaklik_sag_arka, :uzaklik_sol_on, :uzaklik_sol_arka, :uzaklik_on_sag, :uzaklik_on_sol
  attr_accessor :yakinlik_on_sag, :yakinlik_on_sol
  attr_accessor :hareket_sag, :hareket_sol
  attr_accessor :ses, :isik

  # UNO
  attr_accessor :motor_sag_on_enkoder, :motor_sag_arka_enkoder, :motor_sol_on_enkoder, :motor_sol_arka_enkoder
  attr_accessor :yakinlik_yer, :sicaklik


  def print_uzaklik
    puts "Sağ Ön #{uzaklik_sag_on}   Sağ Arka #{uzaklik_sag_arka}   Sol Ön #{uzaklik_sol_on}   Sol Arka #{uzaklik_sol_arka}"
  end

  def print_uzaklik2
    puts "Ön Sağ #{uzaklik_on_sag} Ön Sol #{uzaklik_on_sol}"
  end

  def print_yakinlik
    puts "Ön Sağ #{yakinlik_on_sag}   Ön Sol #{yakinlik_on_sol}"
  end

  def print_sensor
    puts "Işık #{isik}   Hareket #{hareket_sag} #{hareket_sol}   Ses #{ses}"
  end

  def print_uno
    puts "Yer #{yakinlik_yer}"
  end

  def print_enkoder
    puts "#{motor_sag_on_enkoder} - #{motor_sag_arka_enkoder} - #{motor_sol_on_enkoder} - #{motor_sol_arka_enkoder}"
  end

end