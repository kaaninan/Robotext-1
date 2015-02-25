WebSocketP5 socket;


void websocketOnMessage(WebSocketConnection con, String msg){
  println("Mesaj Geldi");
  println(msg);
  println();
  
  if(msg.equals("test")){
    socket.broadcast("çalışıyor");
  }
}

void websocketOnOpen(WebSocketConnection con){
  println("A client joined");
}

void websocketOnClosed(WebSocketConnection con){
  println("A client left");
}


void mousePressed(){
  socket.broadcast("hello from processing!");
}
