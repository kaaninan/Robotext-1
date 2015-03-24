class Sensor

  # MEGA
  attr_accessor :uzaklik_sag_on, :uzaklik_sag_arka, :uzaklik_sol_on, :uzaklik_sol_arka, :uzaklik_on_sag, :uzaklik_on_sol
  attr_accessor :yakinlik_on_sag, :yakinlik_on_sol
  attr_accessor :hareket_sag, :hareket_sol
  attr_accessor :ses, :isik

  # UNO
  attr_accessor :motor_sag_on_enkoder, :motor_sag_arka_enkoder, :motor_sol_on_enkoder, :motor_sol_arka_enkoder
  attr_accessor :yakinlik_yer, :sicaklik


  def get_hareket_sag
    return hareket_sag.to_i
  end

  def get_hareket_sol
    return hareket_sol.to_i
  end

  def get_yakinlik_yer
    return yakinlik_yer.to_i
  end

  def get_ses
    return ses.to_i
  end


  def print_uzaklik
    puts "Sag On #{uzaklik_sag_on}   Sag Arka #{uzaklik_sag_arka}   Sol On #{uzaklik_sol_on}   Sol Arka #{uzaklik_sol_arka}"
  end

  def print_uzaklik2
    puts "On Sag #{uzaklik_on_sag} On Sol #{uzaklik_on_sol}"
  end

  def print_yakinlik
    puts "On Sag #{yakinlik_on_sag}   On Sol #{yakinlik_on_sol}"
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