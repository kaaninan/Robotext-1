class LOG

  def bildirim konum, mesaj

  end


  def islem_basladi konum, mesaj
    puts "=> STARTING - #{konum}, #{mesaj}"
    puts
  end

  def islem_bitti konum, mesaj
    puts "=> FINISHED - #{konum}, #{mesaj}"
    puts
  end


  def durum konum, mesaj
    puts "=> #{konum}, #{mesaj}"
    puts
  end


  def hata konum, mesaj
    puts "ERROR => #{konum}, #{mesaj}"
    puts
  end

end