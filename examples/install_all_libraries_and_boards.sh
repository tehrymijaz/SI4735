<<TodoBefore

PLEASE, read each comment before runing this script.
This script runs on Mac OS and Linux and installs all libraries and boards available on Arduino platform that is used by the examples.
This may be an option to configure your programming environment for arduino and the PU2CLR SI473X library.

First, install the arduino-cli before running this script.

Examples: curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh
          or
          brew install


          See: https://arduino.github.io/arduino-cli/0.30/installation/ for more details

Finally

ATTENTION... Before running the command below you need to know: 
             You can remove libraries and boards you do not intend to use from the script;
             All board installed will consume about 6GB of storage space;
             It may take several minutes or hours if you want to run the command below withou adapting it for your needs.
                  
run this script

./install_all_libraries_and_boards.sh

TodoBefore


echo "This may take several minutes or hours. Please wait!"
echo "Installing the libraries"

# Add all boards used by the examples (ATmega, Attiny, ESP32, STM32 etc)
arduino-cli config init 
arduino-cli config set board_manager.additional_urls http://arduino.esp8266.com/stable/package_esp8266com_index.json \
http://dan.drown.org/stm32duino/package_STM32duino_index.json \
http://drazzy.com/package_drazzy.com_index.json \
https://files.seeedstudio.com/arduino/package_seeeduino_boards_index.json \
https://github.com/earlephilhower/arduino-pico/releases/download/global/package_rp2040_index.json \
https://github.com/stm32duino/BoardManagerFiles/raw/main/package_stmicroelectronics_index.json \
https://github.com/stm32duino/BoardManagerFiles/raw/master/STM32/package_stm_index.json \
https://mcudude.github.io/MegaCore/package_MCUdude_MegaCore_index.json \
https://mcudude.github.io/MightyCore/package_MCUdude_MightyCore_index.json \
https://mcudude.github.io/MiniCore/package_MCUdude_MiniCore_index.json \
https://raw.githubusercontent.com/DavidGuo-CS/OSOYOO_Arduino/main/package_osoyoo_boards_index.json \
https://raw.githubusercontent.com/VSChina/azureiotdevkit_tools/master/package_azureboard_index.json \
https://raw.githubusercontent.com/damellis/attiny/ide-1.6.x-boards-manager/package_damellis_attiny_index.json \
https://raw.githubusercontent.com/dbuezas/lgt8fx/master/package_lgt8fx_index.json \
https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json \
https://raw.githubusercontent.com/nulllaborg/arduino_nulllab/master/package_nulllab_boards_index.json 
arduino-cli core update-index
# Install the PU2CLR SI4735 Arduino Library and all other libraries used by the examples
arduino-cli lib install "PU2CLR SI4735"
arduino-cli lib install "Adafruit BusIO"
arduino-cli lib install "Adafruit SH110X"
arduino-cli lib install "Adafruit SSD1306"
arduino-cli lib install "Adafruit ST7735 and ST7789 Library"
arduino-cli lib install "Adafruit TouchScreen"
arduino-cli lib install "ES32Lab"
arduino-cli lib install "Etherkit Si5351"
arduino-cli lib install "FlashStorage_SAMD"
arduino-cli lib install "LiquidCrystal"
arduino-cli lib install "LiquidCrystal I2C"
arduino-cli lib install "MCUFRIEND_kbv"
arduino-cli lib install "TFT_22_ILI9225"
arduino-cli lib install "TFT_eSPI_ES32Lab"
arduino-cli lib install "Tiny4kOLED"
arduino-cli lib install "TinyOLED-Fonts"
echo "The LCD5110_Graph library needs to be installed manually. See: http://www.rinkydinkelectronics.com/library.php?id=47"
echo "The Adafruit_SH1106 library needs to be installed manually. See: https://github.com/wonho-maker/Adafruit_SH1106"

# Install all boards used by the examples
echo "Installing the boards"
arduino-cli core install arduino:avr
arduino-cli core install lgt8fx:avr
arduino-cli core install MiniCore:avr
arduino-cli core install arduino:sam
arduino-cli core install esp32:esp32
arduino-cli core install esp8266:esp8266
arduino-cli core install stm32duino:STM32F1
arduino-cli core install stm32duino:STM32F4
arduino-cli core install STM32:stm32
arduino-cli core install rp2040:rp2040
arduino-cli core install Seeeduino:samd
arduino-cli core install ATTinyCore:avr
arduino-cli core install MegaCore:avr
arduino-cli core install MightyCore:avr

echo "Finish"