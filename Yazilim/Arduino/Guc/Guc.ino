int role1 = 13;
int role2 = 3;
int role3 = 0;

int analog1 = 5;
int analog2 = 2;
int analog3 = 4;

int led1 = 9;
int led2 = 10;
int led3 = 11;

int buton = 7;

void setup() {
  pinMode(role1, OUTPUT);
  pinMode(role2, OUTPUT);
  pinMode(role3, OUTPUT);

  pinMode(led1, OUTPUT);
  pinMode(led2, OUTPUT);
  pinMode(led3, OUTPUT);

  pinMode(buton, INPUT);

  // Animasyon
  for (int i = 0; i < 5; i++) {
    digitalWrite(led1, HIGH);
    digitalWrite(led2, LOW);
    digitalWrite(led3, LOW);
    delay(100);
    digitalWrite(led1, LOW);
    digitalWrite(led2, HIGH);
    digitalWrite(led3, LOW);
    delay(100);
    digitalWrite(led1, LOW);
    digitalWrite(led2, LOW);
    digitalWrite(led3, HIGH);
    delay(100);
    digitalWrite(led1, LOW);
    digitalWrite(led2, HIGH);
    digitalWrite(led3, LOW);
    delay(100);
  }
  digitalWrite(led1, LOW);
  digitalWrite(led2, LOW);
  digitalWrite(led3, LOW);
}


boolean akuyuSarjEt = false;
boolean panelEnerji = false;
boolean sarjOluyor = false;


void loop() {

  // Role 1'i kapatarak akunun acik gerilimini olc
  digitalWrite(role1, HIGH);

  int akuBosta = analogRead(analog3);
  int oranti1 = map(akuBosta, 0, 1023, 0, 10);

  if (oranti1 < 3) {
    digitalWrite(led1, HIGH);
    digitalWrite(led2, LOW);
    digitalWrite(led3, LOW);
    akuyuSarjEt = true;
  } else if (7 <= oranti1) {
    digitalWrite(led1, LOW);
    digitalWrite(led2, LOW);
    digitalWrite(led3, HIGH);
    akuyuSarjEt = false;
  } else if (3 <= oranti1 < 7) {
    digitalWrite(led1, LOW);
    digitalWrite(led2, HIGH);
    digitalWrite(led3, LOW);
    akuyuSarjEt = false;
  }

  delay(2000);


  // Akuyunun sarj varsa sistemi calistir
  if (akuyuSarjEt == false) {
    digitalWrite(role1, LOW);

    // Akunu yukteki gerilimini olc
    // Surekli olc ve sarj olmasi gerektigi zaman panele bagla
    int akuYukte = analogRead(analog1);
    int oranti2 = map(akuYukte, 0, 1023, 0, 10);

    if (oranti2 < 2) {
      digitalWrite(led1, HIGH);
      digitalWrite(led2, LOW);
      digitalWrite(led3, LOW);
      akuyuSarjEt = true;
    } else if (6 <= oranti2) {
      digitalWrite(led1, LOW);
      digitalWrite(led2, LOW);
      digitalWrite(led3, HIGH);
      akuyuSarjEt = false;
    } else if (2 <= oranti2 < 6) {
      digitalWrite(led1, LOW);
      digitalWrite(led2, HIGH);
      digitalWrite(led3, LOW);
      akuyuSarjEt = false;
    }

  }

  // Akunun sarj azalmissa
  else {
    // Panelden gelen voltaj olc
    int panel = analogRead(analog2);
    int oranti3 = map(panel, 0, 1023, 0, 10);

    if (oranti3 > 6) {
      panelEnerji = true;
    } else {
      panelEnerji = false;
    }

    // Panelden yeterli enerji geldigi zaman
    if (panelEnerji == true) {
      // Akuyu yukten cek
      digitalWrite(role1, HIGH);

      // Paneli reglatore bagla
      digitalWrite(role2, HIGH);

      sarjOluyor = true;

      // ## SARJ OLUYOR
    }


    if (sarjOluyor == true) {
      delay(100000);

      // Akuyu sarjdan cikar ve bosta voltajini olc
      digitalWrite(role3, HIGH);
      
      akuBosta = analogRead(analog3);
      oranti1 = map(akuBosta, 0, 1023, 0, 10);
    
      if (7 <= oranti1) {
        // Sarj bitir
        digitalWrite(role2, LOW);
        // Yuke dogru
        digitalWrite(role1, LOW);
        // Regulatorden cikar
        digitalWrite(role3, LOW);
        
        sarjOluyor = false;
      }else{
        // Sarja devam et
        sarjOluyor = true;
      }
    }
  }

}
