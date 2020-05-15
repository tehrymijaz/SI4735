/*
  Test and validation of the SI4735 Arduino Library on ATtiny85.
  It is a simple AM/FM radio implementation.

  Prototype documentation : https://pu2clr.github.io/SI4735/
  PU2CLR Si47XX API documentation: https://pu2clr.github.io/SI4735/extras/apidoc/html/

  By Ricardo Lima Caratti, Jan 2020.
*/

#include <SI4735.h>
#include <Tiny4kOLED.h>


#define RESET_PIN 3

#define EEPROM_ADDR 0x50

#define SSB_UP      1      // AM/FM SWITCH
#define SSB_DOWN    4    // Seek Up
#define FM_FUNCTION 0
#define AM_FUNCTION 1
#define MAX_TIME 200

uint16_t currentFrequency;
uint16_t lastAmFrequency = 810;     // Starts AM on 810KHz;
uint16_t lastFmFrequency = 10390;   // Starts FM on 103,9MHz

int currentBFO = 0;
uint8_t currentBFOStep = 25;

long lastQuery = millis();

SI4735 si4735;

void setup()
{

  pinMode(SSB_DOWN, INPUT_PULLUP);
  pinMode(SSB_UP, INPUT_PULLUP);

  oled.begin();
  oled.clear();
  oled.on();
  oled.setFont(FONT8X16);
  oled.setCursor(0, 0);
  oled.print("Attiny85");
  delay(2000);
  oled.clear();

  oled.setCursor(0, 1);
  oled.print("SSB...");
  
  // si4735.setup(RESET_PIN, FM_FUNCTION);
  si4735.setup(RESET_PIN, AM_FUNCTION);
  delay(100);

  loadSSB();
  delay(1000);

  // Starts defaul radio function and band (FM; from 84 to 108 MHz; 103.9 MHz; step 100KHz)
  // si4735.setFM(8400, 10800, 10570, 10);
  delay(100);
  si4735.setSSB(520, 1710,  810, 10, 1);
  currentFrequency = si4735.getFrequency();
  si4735.setVolume(55);
  delay(100);
  showStatus();
}

/*
    Shows the currend frequency
*/
void showStatus() {
  oled.clear();
  oled.setCursor(5, 0);
  oled.print("BFO:");
  oled.setCursor(5, 2);
  oled.print(currentBFO);
}

void loadSSB()
{
  si4735_eeprom_patch_header eep;
  si4735.queryLibraryId(); // Is it really necessary here? I will check it.
  si4735.patchPowerUp();
  delay(50);
  eep = si4735.downloadPatchFromEeprom(EEPROM_ADDR);  

  oled.setCursor(0, 0);
  oled.print((char *) eep.refined.patch_id);
  oled.setCursor(0, 2);
  oled.print(eep.refined.patch_size);
 
  // Parameters
  // AUDIOBW - SSB Audio bandwidth; 0 = 1.2KHz (default); 1=2.2KHz; 2=3KHz; 3=4KHz; 4=500Hz; 5=1KHz;
  // SBCUTFLT SSB - side band cutoff filter for band passand low pass filter ( 0 or 1)
  // AVC_DIVIDER  - set 0 for SSB mode; set 3 for SYNC mode.
  // AVCEN - SSB Automatic Volume Control (AVC) enable; 0=disable; 1=enable (default).
  // SMUTESEL - SSB Soft-mute Based on RSSI or SNR (0 or 1).
  // DSP_AFCDIS - DSP AFC Disable or enable; 0=SYNC MODE, AFC enable; 1=SSB MODE, AFC disable.
  si4735.setSSBConfig(2, 1, 0, 1, 0, 1);
}

void loop()
{
  if (digitalRead(SSB_UP) == LOW ) {
     currentBFO += currentBFOStep;
     si4735.setSSBBfo(currentBFO);
     showStatus();
  } else if (digitalRead(SSB_DOWN) == LOW ) {
     currentBFO -= currentBFOStep;
     si4735.setSSBBfo(currentBFO);
    showStatus();
  }
  delay(50);
}
