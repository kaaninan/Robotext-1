int firstSensor = 0;
int secondSensor = 0;
int thirdSensor = 0;
int inByte = 0;

int trig = 22;
int echo = 23;

int led = 13;

String command;

int deger;
int cm = 255;

boolean devam = false;

void setup(){
  Serial.begin(115200);
  
  pinMode(trig, OUTPUT);
  pinMode(echo, INPUT);
  
  pinMode(led, OUTPUT);
  
  establishContact();
}

void loop(){
  if(devam == true){
    digitalWrite(trig, LOW);
    digitalWrite(trig, HIGH);
    digitalWrite(trig, LOW);
    
    deger = pulseIn(echo, HIGH);
    cm = deger/29/2;
    
    devam = false;
  }
}

void serialEvent() {
  
  while (Serial.available()) {
    
    int serialRead = Serial.read();
    
    if(serialRead == '\n'){
      parseCommand(command);
      command = "";
    }else{
      command+= serialRead;
    }
    
    int firstSensor = analogRead(A0);
    int secondSensor = analogRead(A1);

    int deger1 = map(firstSensor, 0, 1023, 0, 255);
    int deger2 = map(secondSensor, 0, 1023, 0, 255);
    
    Serial.print(firstSensor);
    Serial.print(",");
    Serial.println(secondSensor);
    
    if(serialRead == '1'){
      devam = true;
    }
  }
}

void parseCommand(String com){
  String part1;
  String part2;
  
  part1 = com.substring(0, com.indexOf(" "));
  part2 = com.substring(com.indexOf(" ") + 1);
  
  if(part1.equalsIgnoreCase("pinon")){
    int pin = part2.toInt();    
    digitalWrite(pin, HIGH);
  }
  else if(part1.equalsIgnoreCase("pinoff")){
    int pin = part2.toInt();
    digitalWrite(pin, LOW);
  }
}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.println("0,0,0");
    delay(300);
  }
}
