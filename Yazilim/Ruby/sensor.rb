class Sensor

  # MEGA
  attr_accessor :uzaklik_on, :uzaklik_arka, :uzaklik_sag, :uzaklik_sol
  attr_accessor :hareket_sag, :hareket_sol
  attr_accessor :ses, :isik, :gaz
  attr_accessor :uzaklik_on_sag, :uzaklik_on_sol

  # UNO
  attr_accessor :motor_sag_on_enkoder, :motor_sag_arka_enkoder, :motor_sol_on_enkoder, :motor_sol_arka_enkoder
  attr_accessor :sicaklik


  def print_sonic
    puts "Sag On: #{@uzaklik_on_sag}  Sol On: #{@uzaklik_on_sol}"
  end

  def print_uzaklik
    puts "On #{@uzaklik_on}   Arka #{@uzaklik_arka}   Sag #{@uzaklik_sag}   Sol #{@uzaklik_sol}"
  end

  def print_sensor
    puts "Isik #{@isik}   Hareket #{@hareket_sag} #{@hareket_sol}   Ses #{@ses}  Sicaklik #{@sicaklik}  Gaz #{@gaz}"
  end

  def print_enkoder
    puts "#{@motor_sag_on_enkoder} - #{@motor_sag_arka_enkoder} - #{@motor_sol_on_enkoder} - #{@motor_sol_arka_enkoder}"
  end

end