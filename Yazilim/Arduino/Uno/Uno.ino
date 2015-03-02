int trig = 2;
int echo = 3;

int trig2 = 4;
int echo2 = 5;

long deger;
long cm;

long deger2;
long cm2;

int sag_on = 0;
int sag_arka = 1;
int sol_on = 2;
int sol_arka = 3;

int a = 0;

void setup() {
  pinMode(trig, OUTPUT);
  pinMode(echo, INPUT);
  
  pinMode(trig2, OUTPUT);
  pinMode(echo2, INPUT);
  
  Serial.begin(115200);
  
  establishContact();

}

void loop() {
  
  if(a == 0){
    digitalWrite(trig, LOW);
    digitalWrite(trig, HIGH);
    digitalWrite(trig, LOW);
    
    deger = pulseIn(echo, HIGH, 10000);
    cm = deger/29/2;
    delay(50);
    
    a = 1;
    
  }else{
    digitalWrite(trig2, LOW);
    digitalWrite(trig2, HIGH);
    digitalWrite(trig2, LOW);
    
    deger2 = pulseIn(echo2, HIGH, 10000);
    cm2 = deger2/29/2;
    delay(50);
    
    a = 0;
  }
  
  
  Serial.print(oku(sag_on));
  Serial.print(",");
  Serial.print(oku(sag_arka));
  Serial.print(",");
  Serial.print(oku(sol_on));
  Serial.print(",");
  Serial.print(oku(sol_arka));
  
  Serial.print(",");
  Serial.print(cm);
  Serial.print(",");
  Serial.println(cm2);
  
}


int oku(int pin){
  char GP2D12=read_gp2d12_range(pin);
  char a=GP2D12/10;
  char b=GP2D12%10;
  int val = a*10+b;
 
  if(val>10&&val<80){
    return val;
  }else{
    return 0;
  }
}


float read_gp2d12_range(int pin){
  int tmp = analogRead(pin);
  if (tmp < 3) return -1;
  return (6787.0 /((float)tmp - 3.0)) - 4.0;
}


void establishContact() {
  while (Serial.available() <= 0) {
    Serial.println("0");
    delay(100);
  }
}
