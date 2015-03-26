class Sensor

  # MEGA
  attr_accessor :uzaklik_on, :uzaklik_arka, :uzaklik_sag, :uzaklik_sol
  attr_accessor :hareket_sag, :hareket_sol
  attr_accessor :ses, :isik

  # UNO
  attr_accessor :motor_sag_on_enkoder, :motor_sag_arka_enkoder, :motor_sol_on_enkoder, :motor_sol_arka_enkoder
  attr_accessor :yakinlik_yer, :sicaklik


  def print_uzaklik
    puts "On #{uzaklik_on}   Arka #{uzaklik_arka}   Sag #{uzaklik_sag}   Sol #{uzaklik_sol}"
  end

  def print_sensor
    puts "Isik #{isik}   Hareket #{hareket_sag} #{hareket_sol}   Ses #{ses}  Sicaklik #{sicaklik}"
  end

  def print_uno
    puts "Yer #{yakinlik_yer}"
  end

  def print_enkoder
    puts "#{motor_sag_on_enkoder} - #{motor_sag_arka_enkoder} - #{motor_sol_on_enkoder} - #{motor_sol_arka_enkoder}"
  end

end