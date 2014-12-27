BodyPart messageBodyPart;


void sendMailBirinci() {
  
  try {

    Properties props = new Properties();

    props.put("mail.smtp.host", "smtp.gmail.com");
    props.put("mail.smtp.socketFactory.port", "465");
    props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.port", "465");

    // Create authentication object
    Auth auth = new Auth();

    Session session = Session.getDefaultInstance(props, auth);

    try {
      
      println("Mail Düzenleniyor");

      Message message = new MimeMessage(session);
      message.setFrom(new InternetAddress("robotext.afl@gmail.com"));
      message.setRecipients(Message.RecipientType.TO, InternetAddress.parse("kaaninan99@gmail.com"));
      message.setSubject("Robotext Güvenlik Sistemi - Uyarı");
      
      
      MimeMultipart multipart = new MimeMultipart("related");
      
      // EK 1
      messageBodyPart = new MimeBodyPart();
      messageBodyPart.setContent( htmlBirinci, "text/html; charset=utf-8" );
      multipart.addBodyPart(messageBodyPart);

      // EK 2
      
      int toplam = resim_no - resim_baslangic; // resim no bir fazla
      
      for(int i = resim_baslangic; i < (toplam+resim_baslangic) ; i++){
        messageBodyPart = new MimeBodyPart();
        String filename = "/home/pi/resimler/guvenlik-"+i+".jpg";
        DataSource source = new FileDataSource(filename);
        messageBodyPart.setDataHandler(new DataHandler(source));
        messageBodyPart.setFileName(filename);
        messageBodyPart.setHeader("Content-ID","resim"+i);
        multipart.addBodyPart(messageBodyPart);
      };

      // Herşeyi Koy
      message.setContent(multipart);
      
      Transport.send(message);

      System.out.println("Birinci Mail Gonderildi");
    } 

    finally 
    {
      //session.close();
    }
  }
  catch (MessagingException e) 
  {
    throw new RuntimeException(e);
  }
}



void sendMailIkinci() {
  
  try {

    Properties props = new Properties();

    props.put("mail.smtp.host", "smtp.gmail.com");
    props.put("mail.smtp.socketFactory.port", "465");
    props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.port", "465");

    // Create authentication object
    Auth auth = new Auth();

    Session session = Session.getDefaultInstance(props, auth);

    try {
      
      println("Mail Düzenleniyor");

      Message message = new MimeMessage(session);
      message.setFrom(new InternetAddress("robotext.afl@gmail.com"));
      message.setRecipients(Message.RecipientType.TO, InternetAddress.parse("kaaninan99@gmail.com"));
      message.setSubject("Robotext Güvenlik Sistemi - Uyarı");
      
      
      MimeMultipart multipart = new MimeMultipart("related");
      
      // EK 1
      messageBodyPart = new MimeBodyPart();
      messageBodyPart.setContent( htmlIkinci, "text/html; charset=utf-8" );
      multipart.addBodyPart(messageBodyPart);

      // EK 2
      
      int toplam = resim_no - resim_baslangic; // resim no bir fazla
      
      for(int i = resim_baslangic; i < (toplam+resim_baslangic) ; i++){
        messageBodyPart = new MimeBodyPart();
        String filename = "/home/pi/resimler/guvenlik-"+i+".jpg";
        DataSource source = new FileDataSource(filename);
        messageBodyPart.setDataHandler(new DataHandler(source));
        messageBodyPart.setFileName(filename);
        messageBodyPart.setHeader("Content-ID","resim"+i);
        multipart.addBodyPart(messageBodyPart);
      };

      // Herşeyi Koy
      message.setContent(multipart);
      
      Transport.send(message);

      System.out.println("İkinci Mail Gonderildi");
    } 

    finally 
    {
      //session.close();
    }
  }
  catch (MessagingException e) 
  {
    throw new RuntimeException(e);
  }
}





void sendMailBasla() {
  
  try {

    Properties props = new Properties();

    props.put("mail.smtp.host", "smtp.gmail.com");
    props.put("mail.smtp.socketFactory.port", "465");
    props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.port", "465");

    // Create authentication object
    Auth auth = new Auth();

    Session session = Session.getDefaultInstance(props, auth);

    try {
      
      println("Baslangic Maili Düzenleniyor");

      Message message = new MimeMessage(session);
      message.setFrom(new InternetAddress("robotext.afl@gmail.com"));
      message.setRecipients(Message.RecipientType.TO, InternetAddress.parse("kaaninan99@gmail.com"));
      message.setSubject("Robotext Güvenlik Sistemi - Artık Güvendesiniz");
      
      
      MimeMultipart multipart = new MimeMultipart("related");
      
      // EK 1
      messageBodyPart = new MimeBodyPart();
      messageBodyPart.setContent( htmlBasla, "text/html; charset=utf-8" );
      multipart.addBodyPart(messageBodyPart);

      // Herşeyi Koy
      message.setContent(multipart);
      
      Transport.send(message);

      System.out.println("Baslangic Mail Gonderildi");
    } 

    finally 
    {
      //session.close();
    }
  }
  catch (MessagingException e) 
  {
    throw new RuntimeException(e);
  }
}










void checkMail() {
  try {

    IMAPFolder folder = null;
    Store store = null;
    String subject = null;
    Flag flag = null;
    try 
    {
      Properties props = System.getProperties();
      props.setProperty("mail.store.protocol", "imaps");
      props.put("mail.imaps.host", "imap.gmail.com");

      // Create authentication object
      Auth auth = new Auth();

      // Make a session
      Session session = Session.getDefaultInstance(props, auth);
      store = session.getStore("imaps");

      store.connect();

      folder = (IMAPFolder) store.getFolder("Inbox"); 

      if (!folder.isOpen())
        folder.open(Folder.READ_WRITE);

      Message[] messages = folder.getMessages();
      System.out.println("No of Messages : " + folder.getMessageCount());
      System.out.println("No of Unread Messages : " + folder.getUnreadMessageCount());
      System.out.println(messages.length);

      for (int i=0; i < 10;i++)
        //for (int i=0; i < messages.length;i++) 
      {

        System.out.println("*****************************************************************************");
        System.out.println("MESSAGE " + (i + 1) + ":");
        Message msg =  messages[i];
        //System.out.println(msg.getMessageNumber());
        //Object String;
        //System.out.println(folder.getUID(msg)

        subject = msg.getSubject();

        System.out.println("Subject: " + subject);
        System.out.println("From: " + msg.getFrom()[0]);
        System.out.println("To: "+msg.getAllRecipients()[0]);
        System.out.println("Date: "+msg.getReceivedDate());
        System.out.println("Size: "+msg.getSize());
        System.out.println(msg.getFlags());
        System.out.println("Body: \n"+ msg.getContent());
        System.out.println(msg.getContentType());
      }
    }
    finally 
    {
      if (folder != null && folder.isOpen()) { 
        folder.close(true);
      }
      if (store != null) { 
        store.close();
      }
    }
  }


  // This error handling isn't very good
  catch (Exception e) {
    System.out.println("Failed to connect to the store");
    e.printStackTrace();
  }
}
