void setup() {
  Serial.begin(9600);

  byte* bayt;
  char* kaan;
  char* yeni;
  
  kaan[0] = 'k';
  kaan[1] = 'a';
  kaan[2] = 'a';
  kaan[3] = 'n';
  
  
  for(int i = 0; i < 4; i++){
    bayt[i] = byte(kaan[i]);
  }
    
  Serial.println(kaan);
  Serial.println("-----");
  Serial.println(bayt);
  
  
  for(int i = 0; i < 4; i++){
    yeni[i] = char(bayt[i]);
  }
  
  Serial.println("------");
  Serial.println(yeni);

}

void loop() {
  // put your main code here, to run repeatedly:

}
