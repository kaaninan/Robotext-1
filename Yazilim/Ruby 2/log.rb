class LOG

  def initialize
    puts '=> LOG SISTEMI AKTIFLESTIRILDI <=='
    puts
    puts
  end


  def bildirim konum, mesaj

  end


  def islem_basladi konum, mesaj
    puts "=> STARTING - #{konum}, #{mesaj}"
    puts
    puts
  end

  def islem_bitti konum, mesaj
    puts "=> FINISHED - #{konum}, #{mesaj}"
    puts
    puts
  end


  def durum konum, mesaj
    puts "=> #{konum}, #{mesaj}"
    puts
    puts
  end


  def hata konum, mesaj
    puts "ERROR => #{konum}, #{mesaj}"
    puts
    puts
  end

end