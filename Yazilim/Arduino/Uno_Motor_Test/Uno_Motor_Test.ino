void setup() {
  
  for(int i = 0; i < 10; i++)
    pinMode(i, OUTPUT);

}

void loop() {
  
  Serial.begin(115200);
  
  encoder();
  
  hiz();
  
//  a1(); // GERİ
  a2(); // İLERİ
  //a3(); // SAG
  //a4(); // SOL
  
}


void a1(){
  digitalWrite(2, HIGH);
  digitalWrite(4, LOW);
  digitalWrite(7, HIGH);
  digitalWrite(8, LOW);
}

void a2(){
  digitalWrite(2, LOW);
  digitalWrite(4, HIGH);
  digitalWrite(7, LOW);
  digitalWrite(8, HIGH);
}

void a3(){
  digitalWrite(2, LOW);
  digitalWrite(4, HIGH);
  digitalWrite(7, HIGH);
  digitalWrite(8, LOW);
}

void a4(){
  digitalWrite(2, HIGH);
  digitalWrite(4, LOW);
  digitalWrite(7, LOW);
  digitalWrite(8, HIGH);
}




void hiz(){
  digitalWrite(3, HIGH);
  digitalWrite(5, HIGH);
  digitalWrite(6, HIGH);
  digitalWrite(9, HIGH);
}

void yavasla(){
  digitalWrite(3, LOW);
  digitalWrite(5, LOW);
  digitalWrite(6, LOW);
  digitalWrite(9, LOW);
}

void encoder(){
  Serial.print("1- ");
  Serial.print(analogRead(0));
  Serial.print("    2- ");
  Serial.print(analogRead(1));
  Serial.print("    3- ");
  Serial.print(analogRead(2));
  Serial.print("    4- ");
  Serial.println(analogRead(3));
}

