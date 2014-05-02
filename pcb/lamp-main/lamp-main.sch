EESchema Schematic File Version 2
LIBS:power
LIBS:7400-ic
LIBS:analog-ic
LIBS:avr-mcu
LIBS:bluegiga
LIBS:connector
LIBS:freescale-ic
LIBS:ftdi-ic
LIBS:maxim-ic
LIBS:micrel-ic
LIBS:microchip-ic
LIBS:nxp-ic
LIBS:rohm
LIBS:sharp-relay
LIBS:sparkfun
LIBS:standard
LIBS:stmicro-mcu
LIBS:ti-ic
LIBS:uln-ic
LIBS:led
LIBS:lamp-main-cache
EELAYER 24 0
EELAYER END
$Descr A 11000 8500
encoding utf-8
Sheet 1 1
Title "lamp pcb"
Date "26 Feb 2014"
Rev "0.1"
Comp "copyright 2014 by Wiley Cousins"
Comment1 "shared under the terms of the Creative Commons Attribution-ShareAlike 4.0 license"
Comment2 "github.com/wileycousins/lamp"
Comment3 "open source hardware"
Comment4 ""
$EndDescr
$Comp
L ATMEGA328P_TQFP IC1
U 1 1 530E2A6B
P 3350 2250
F 0 "IC1" H 2650 3400 60  0000 C CNN
F 1 "ATMEGA328P" H 3700 1050 60  0000 C CNN
F 2 "" H 3350 2250 60  0000 C CNN
F 3 "" H 3350 2250 60  0000 C CNN
F 4 "Atmel" H 3350 2250 60  0001 C CNN "Manufacturer"
F 5 "ATMEGA328P-AU" H 3350 2250 60  0001 C CNN "Manufacturer Part"
F 6 "Digikey" H 3350 2250 60  0001 C CNN "Distributor"
F 7 "ATMEGA328P-AU-ND" H 3350 2250 60  0001 C CNN "Distributor Part"
F 8 "http://www.digikey.com/product-detail/en/ATMEGA328P-AU/ATMEGA328P-AU-ND/1832260" H 3350 2250 60  0001 C CNN "Distributor Link"
	1    3350 2250
	1    0    0    -1  
$EndComp
$Comp
L AVR_ISP P2
U 1 1 530E2A7F
P 1950 5100
F 0 "P2" H 1700 5300 60  0000 C CNN
F 1 "AVR_ISP" H 2100 5300 60  0000 C CNN
F 2 "" H 1950 5100 60  0001 C CNN
F 3 "" H 1950 5100 60  0001 C CNN
	1    1950 5100
	1    0    0    -1  
$EndComp
$Comp
L 6PIN_HEADER P3
U 1 1 530E2A93
P 4050 5050
F 0 "P3" H 4050 5550 60  0000 C CNN
F 1 "SERIAL" H 4000 5450 60  0000 C CNN
F 2 "" H 4100 5050 60  0001 C CNN
F 3 "" H 4100 5050 60  0001 C CNN
	1    4050 5050
	1    0    0    -1  
$EndComp
$Comp
L CRYSTAL Y1
U 1 1 530E2AA7
P 2150 2500
F 0 "Y1" V 2200 2700 60  0000 C CNN
F 1 "8MHz" V 2100 2700 60  0000 C CNN
F 2 "" H 2150 2500 60  0001 C CNN
F 3 "http://www.abracon.com/Resonators/abm2.pdf" H 2150 2500 60  0001 C CNN
F 4 "Abracon Corporation" H 2150 2500 60  0001 C CNN "Manufacturer"
F 5 "ABM2-8.000MHZ-D4Y-T" H 2150 2500 60  0001 C CNN "Manuf. Part"
F 6 "Digikey" H 2150 2500 60  0001 C CNN "Distributor"
F 7 "535-10870-1-ND" H 2150 2500 60  0001 C CNN "Distrib. Part"
F 8 "http://www.digikey.com/product-detail/en/ABM2-8.000MHZ-D4Y-T/535-10870-1-ND/2624229" H 2150 2500 60  0001 C CNN "Distrib. Link"
	1    2150 2500
	0    -1   -1   0   
$EndComp
$Comp
L C C2
U 1 1 530E2B0B
P 1500 2400
F 0 "C2" H 1350 2550 60  0000 C CNN
F 1 "24pF" H 1600 2550 60  0000 C CNN
F 2 "" H 1500 2400 60  0001 C CNN
F 3 "" H 1500 2400 60  0001 C CNN
F 4 "Samsung" H 1500 2400 60  0001 C CNN "Manufacturer"
F 5 "CL10C240JB8NCNC" H 1500 2400 60  0001 C CNN "Manuf. Part"
F 6 "Digikey" H 1500 2400 60  0001 C CNN "Distributor"
F 7 "1276-2242-1-ND" H 1500 2400 60  0001 C CNN "Distrib. Part"
F 8 "http://www.digikey.com/product-detail/en/CL10C240JB8NCNC/1276-2242-1-ND/3890328" H 1500 2400 60  0001 C CNN "Distrib. Link"
	1    1500 2400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR01
U 1 1 530E2B38
P 1200 2500
F 0 "#PWR01" H 1200 2500 30  0001 C CNN
F 1 "GND" H 1200 2430 30  0001 C CNN
F 2 "" H 1200 2500 60  0000 C CNN
F 3 "" H 1200 2500 60  0000 C CNN
	1    1200 2500
	0    1    1    0   
$EndComp
Text Label 1850 2750 0    60   ~ 0
AVR_SCK
Text Label 1850 2850 0    60   ~ 0
AVR_MISO
Text Label 1850 2950 0    60   ~ 0
AVR_MOSI
Text Label 1850 1250 0    60   ~ 0
AVR_RST
$Comp
L C C6
U 1 1 530E2C15
P 2100 2250
F 0 "C6" H 1950 2450 60  0000 C CNN
F 1 "0.1uF" H 1950 2350 60  0000 C CNN
F 2 "" H 2100 2250 60  0001 C CNN
F 3 "" H 2100 2250 60  0001 C CNN
F 4 "On hand" H 2100 2250 60  0001 C CNN "Distributor"
	1    2100 2250
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 530E2C3A
P 1900 2250
F 0 "#PWR02" H 1900 2250 30  0001 C CNN
F 1 "GND" H 1900 2180 30  0001 C CNN
F 2 "" H 1900 2250 60  0000 C CNN
F 3 "" H 1900 2250 60  0000 C CNN
	1    1900 2250
	0    1    1    0   
$EndComp
$Comp
L VCC #PWR03
U 1 1 530E2CEA
P 1150 1850
F 0 "#PWR03" H 1150 1950 30  0001 C CNN
F 1 "VCC" H 1150 1950 30  0000 C CNN
F 2 "" H 1150 1850 60  0000 C CNN
F 3 "" H 1150 1850 60  0000 C CNN
	1    1150 1850
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR04
U 1 1 530E2D76
P 1150 1650
F 0 "#PWR04" H 1150 1650 30  0001 C CNN
F 1 "GND" H 1150 1580 30  0001 C CNN
F 2 "" H 1150 1650 60  0000 C CNN
F 3 "" H 1150 1650 60  0000 C CNN
	1    1150 1650
	0    1    1    0   
$EndComp
$Comp
L C C1
U 1 1 530E2DE7
P 1350 1750
F 0 "C1" V 1650 1750 60  0000 C CNN
F 1 "0.1uF" V 1550 1750 60  0000 C CNN
F 2 "" H 1350 1750 60  0001 C CNN
F 3 "" H 1350 1750 60  0001 C CNN
F 4 "On Hand" H 1350 1750 60  0001 C CNN "Distributor"
	1    1350 1750
	0    -1   -1   0   
$EndComp
$Comp
L C C4
U 1 1 530E2DFB
P 1650 1750
F 0 "C4" V 1950 1750 60  0000 C CNN
F 1 "0.1uF" V 1850 1750 60  0000 C CNN
F 2 "" H 1650 1750 60  0001 C CNN
F 3 "" H 1650 1750 60  0001 C CNN
F 4 "On hand" H 1650 1750 60  0001 C CNN "Distributor"
	1    1650 1750
	0    -1   -1   0   
$EndComp
$Comp
L C C5
U 1 1 530E2E0F
P 1950 1750
F 0 "C5" V 2250 1750 60  0000 C CNN
F 1 "0.1uF" V 2150 1750 60  0000 C CNN
F 2 "" H 1950 1750 60  0001 C CNN
F 3 "" H 1950 1750 60  0001 C CNN
F 4 "On hand" H 1950 1750 60  0001 C CNN "Distributor"
	1    1950 1750
	0    -1   -1   0   
$EndComp
Text Label 1000 5200 0    60   ~ 0
AVR_RST
Text Label 1000 5100 0    60   ~ 0
AVR_SCK
Text Label 1000 5000 0    60   ~ 0
AVR_MISO
Text Label 2900 5100 2    60   ~ 0
AVR_MOSI
$Comp
L VCC #PWR05
U 1 1 530E3068
P 2500 4950
F 0 "#PWR05" H 2500 5050 30  0001 C CNN
F 1 "VCC" H 2500 5050 30  0000 C CNN
F 2 "" H 2500 4950 60  0000 C CNN
F 3 "" H 2500 4950 60  0000 C CNN
	1    2500 4950
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR06
U 1 1 530E307C
P 2500 5250
F 0 "#PWR06" H 2500 5250 30  0001 C CNN
F 1 "GND" H 2500 5180 30  0001 C CNN
F 2 "" H 2500 5250 60  0000 C CNN
F 3 "" H 2500 5250 60  0000 C CNN
	1    2500 5250
	1    0    0    -1  
$EndComp
Text Label 5350 2650 2    60   ~ 0
USART_TX
Text Label 5350 2750 2    60   ~ 0
USART_RX
$Comp
L GND #PWR07
U 1 1 530E3278
P 3750 4800
F 0 "#PWR07" H 3750 4800 30  0001 C CNN
F 1 "GND" H 3750 4730 30  0001 C CNN
F 2 "" H 3750 4800 60  0000 C CNN
F 3 "" H 3750 4800 60  0000 C CNN
	1    3750 4800
	0    1    1    0   
$EndComp
$Comp
L VCC #PWR08
U 1 1 530E32F0
P 3750 5000
F 0 "#PWR08" H 3750 5100 30  0001 C CNN
F 1 "VCC" H 3750 5100 30  0000 C CNN
F 2 "" H 3750 5000 60  0000 C CNN
F 3 "" H 3750 5000 60  0000 C CNN
	1    3750 5000
	0    -1   -1   0   
$EndComp
Text Label 3100 5100 0    60   ~ 0
USART_RX
Text Label 3100 5200 0    60   ~ 0
USART_TX
Text Label 3100 5300 0    60   ~ 0
AVR_RST
$Comp
L 2PIN_MALE P1
U 1 1 530E35EB
P 7150 3900
F 0 "P1" H 7350 3900 60  0000 C CNN
F 1 "VLED_IN" H 7050 3700 60  0000 C CNN
F 2 "" H 7100 3700 60  0001 C CNN
F 3 "" H 7100 3700 60  0001 C CNN
	1    7150 3900
	1    0    0    -1  
$EndComp
Text Label 6850 3850 0    60   ~ 0
VIN
$Comp
L GND #PWR09
U 1 1 530E3694
P 6900 3950
F 0 "#PWR09" H 6900 3950 30  0001 C CNN
F 1 "GND" H 6900 3880 30  0001 C CNN
F 2 "" H 6900 3950 60  0000 C CNN
F 3 "" H 6900 3950 60  0000 C CNN
	1    6900 3950
	0    1    1    0   
$EndComp
$Comp
L LM1117 IC2
U 1 1 530E4152
P 8400 4100
F 0 "IC2" H 8400 4500 60  0000 C CNN
F 1 "DNP(LM1117_3.3)" H 8400 4400 60  0000 C CNN
F 2 "" H 8400 4100 60  0001 C CNN
F 3 "http://www.diodes.com/datasheets/AZ1117C.pdf" H 8400 4100 60  0001 C CNN
F 4 "Diodes Incorporated" H 8400 4100 60  0001 C CNN "Manufacturer"
F 5 "AZ1117CH-5.0TRG1" H 8400 4100 60  0001 C CNN "Manuf. Part"
F 6 "Digikey" H 8400 4100 60  0001 C CNN "Distributor"
F 7 "AZ1117CH-5.0TRG1DICT-ND" H 8400 4100 60  0001 C CNN "Distrib. Part"
F 8 "http://www.digikey.com/product-detail/en/AZ1117CH-5.0TRG1/AZ1117CH-5.0TRG1DICT-ND/4505207" H 8400 4100 60  0001 C CNN "Distrib. Link"
	1    8400 4100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR010
U 1 1 530E4235
P 7850 4000
F 0 "#PWR010" H 7850 4000 30  0001 C CNN
F 1 "GND" H 7850 3930 30  0001 C CNN
F 2 "" H 7850 4000 60  0000 C CNN
F 3 "" H 7850 4000 60  0000 C CNN
	1    7850 4000
	0    1    1    0   
$EndComp
$Comp
L VCC #PWR011
U 1 1 530E4249
P 7650 4000
F 0 "#PWR011" H 7650 4100 30  0001 C CNN
F 1 "VCC" H 7650 4100 30  0000 C CNN
F 2 "" H 7650 4000 60  0000 C CNN
F 3 "" H 7650 4000 60  0000 C CNN
	1    7650 4000
	1    0    0    -1  
$EndComp
Text Label 7650 4200 0    60   ~ 0
VIN
$Comp
L VCC #PWR012
U 1 1 530E4380
P 8950 4100
F 0 "#PWR012" H 8950 4200 30  0001 C CNN
F 1 "VCC" H 8950 4200 30  0000 C CNN
F 2 "" H 8950 4100 60  0000 C CNN
F 3 "" H 8950 4100 60  0000 C CNN
	1    8950 4100
	0    1    1    0   
$EndComp
$Comp
L C_POL C7
U 1 1 530E44C1
P 7850 4400
F 0 "C7" V 7850 4550 60  0000 C CNN
F 1 "DNP(10uF)" V 7950 4700 60  0000 C CNN
F 2 "" H 7850 4400 60  0001 C CNN
F 3 "" H 7850 4400 60  0001 C CNN
F 4 "Taiyo Yuden" H 7850 4400 60  0001 C CNN "Manufacturer"
F 5 "TMK316F106ZL-T" H 7850 4400 60  0001 C CNN "Manuf. Part"
F 6 "Digikey" H 7850 4400 60  0001 C CNN "Distributor"
F 7 "587-1353-1-ND" H 7850 4400 60  0001 C CNN "Distrib. Part"
F 8 "http://www.digikey.com/product-detail/en/TMK316F106ZL-T/587-1353-1-ND/931130" H 7850 4400 60  0001 C CNN "Distrib. Link"
	1    7850 4400
	0    1    1    0   
$EndComp
$Comp
L C_POL C8
U 1 1 530E44E9
P 8900 4300
F 0 "C8" V 8900 4500 60  0000 C CNN
F 1 "DNP(22uF)" V 9000 4650 60  0000 C CNN
F 2 "" H 8900 4300 60  0001 C CNN
F 3 "" H 8900 4300 60  0001 C CNN
F 4 "Taiyo Yuden" H 8900 4300 60  0001 C CNN "Manufacturer"
F 5 "LMK316F226ZL-T" H 8900 4300 60  0001 C CNN "Manuf. Part"
F 6 "Digikey" H 8900 4300 60  0001 C CNN "Distributor"
F 7 "587-1356-1-ND" H 8900 4300 60  0001 C CNN "Distrib. Part"
F 8 "http://www.digikey.com/product-detail/en/LMK316F226ZL-T/587-1356-1-ND/931133" H 8900 4300 60  0001 C CNN "Distrib. Link"
	1    8900 4300
	0    1    1    0   
$EndComp
$Comp
L GND #PWR013
U 1 1 530E4552
P 7850 4600
F 0 "#PWR013" H 7850 4600 30  0001 C CNN
F 1 "GND" H 7850 4530 30  0001 C CNN
F 2 "" H 7850 4600 60  0000 C CNN
F 3 "" H 7850 4600 60  0000 C CNN
	1    7850 4600
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR014
U 1 1 530E4566
P 8900 4500
F 0 "#PWR014" H 8900 4500 30  0001 C CNN
F 1 "GND" H 8900 4430 30  0001 C CNN
F 2 "" H 8900 4500 60  0000 C CNN
F 3 "" H 8900 4500 60  0000 C CNN
	1    8900 4500
	1    0    0    -1  
$EndComp
Text Label 5100 1800 2    60   ~ 0
STACKSENSE0
Text Label 5100 1700 2    60   ~ 0
STACKSENSE1
Text Label 5100 1600 2    60   ~ 0
STACKSENSE2
$Comp
L R R2
U 1 1 530E6B4A
P 5350 1700
F 0 "R2" H 5250 2000 60  0000 C CNN
F 1 "10kΩ" H 5550 2000 60  0000 C CNN
F 2 "" H 5350 1700 60  0001 C CNN
F 3 "" H 5350 1700 60  0001 C CNN
F 4 "On hand" H 5350 1700 60  0001 C CNN "Distributor"
	1    5350 1700
	1    0    0    -1  
$EndComp
$Comp
L R R3
U 1 1 530E6B5E
P 5350 1800
F 0 "R3" H 5250 2100 60  0000 C CNN
F 1 "10kΩ" H 5550 2100 60  0000 C CNN
F 2 "" H 5350 1800 60  0001 C CNN
F 3 "" H 5350 1800 60  0001 C CNN
F 4 "On hand" H 5350 1800 60  0001 C CNN "Distributor"
	1    5350 1800
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR015
U 1 1 530E6B72
P 5700 1700
F 0 "#PWR015" H 5700 1700 30  0001 C CNN
F 1 "GND" H 5700 1630 30  0001 C CNN
F 2 "" H 5700 1700 60  0000 C CNN
F 3 "" H 5700 1700 60  0000 C CNN
	1    5700 1700
	0    -1   -1   0   
$EndComp
Text Label 5100 2200 2    60   ~ 0
LEDSTACK0
Text Label 5100 2100 2    60   ~ 0
LEDSTACK1
Text Label 5100 2000 2    60   ~ 0
LEDSTACK2
$Comp
L 5PIN_MALE P4
U 1 1 530E7494
P 7450 1300
F 0 "P4" H 7650 1500 60  0000 C CNN
F 1 "LEDSTACK" H 7800 1400 60  0000 C CNN
F 2 "" H 7500 1200 60  0001 C CNN
F 3 "" H 7500 1200 60  0001 C CNN
	1    7450 1300
	1    0    0    -1  
$EndComp
Text Label 7100 1100 0    60   ~ 0
VIN
$Comp
L VCC #PWR016
U 1 1 530E7504
P 6950 1200
F 0 "#PWR016" H 6950 1300 30  0001 C CNN
F 1 "VCC" H 6950 1300 30  0000 C CNN
F 2 "" H 6950 1200 60  0000 C CNN
F 3 "" H 6950 1200 60  0000 C CNN
	1    6950 1200
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR017
U 1 1 530E7518
P 6800 1200
F 0 "#PWR017" H 6800 1200 30  0001 C CNN
F 1 "GND" H 6800 1130 30  0001 C CNN
F 2 "" H 6800 1200 60  0000 C CNN
F 3 "" H 6800 1200 60  0000 C CNN
	1    6800 1200
	-1   0    0    1   
$EndComp
Text Label 6650 1400 0    60   ~ 0
LEDSTACK0
Text Label 6650 1500 0    60   ~ 0
STACKSENSE0
$Comp
L 5PIN_MALE P5
U 1 1 530E7712
P 7450 2000
F 0 "P5" H 7650 2200 60  0000 C CNN
F 1 "LEDSTACK" H 7800 2100 60  0000 C CNN
F 2 "" H 7500 1900 60  0001 C CNN
F 3 "" H 7500 1900 60  0001 C CNN
	1    7450 2000
	1    0    0    -1  
$EndComp
Text Label 7100 1800 0    60   ~ 0
VIN
$Comp
L VCC #PWR018
U 1 1 530E7719
P 6950 1900
F 0 "#PWR018" H 6950 2000 30  0001 C CNN
F 1 "VCC" H 6950 2000 30  0000 C CNN
F 2 "" H 6950 1900 60  0000 C CNN
F 3 "" H 6950 1900 60  0000 C CNN
	1    6950 1900
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR019
U 1 1 530E771F
P 6800 1900
F 0 "#PWR019" H 6800 1900 30  0001 C CNN
F 1 "GND" H 6800 1830 30  0001 C CNN
F 2 "" H 6800 1900 60  0000 C CNN
F 3 "" H 6800 1900 60  0000 C CNN
	1    6800 1900
	-1   0    0    1   
$EndComp
Text Label 6650 2100 0    60   ~ 0
LEDSTACK1
Text Label 6650 2200 0    60   ~ 0
STACKSENSE1
$Comp
L 5PIN_MALE P6
U 1 1 530E775C
P 7450 2700
F 0 "P6" H 7650 2900 60  0000 C CNN
F 1 "LEDSTACK" H 7800 2800 60  0000 C CNN
F 2 "" H 7500 2600 60  0001 C CNN
F 3 "" H 7500 2600 60  0001 C CNN
	1    7450 2700
	1    0    0    -1  
$EndComp
Text Label 7100 2500 0    60   ~ 0
VIN
$Comp
L VCC #PWR020
U 1 1 530E7763
P 6950 2600
F 0 "#PWR020" H 6950 2700 30  0001 C CNN
F 1 "VCC" H 6950 2700 30  0000 C CNN
F 2 "" H 6950 2600 60  0000 C CNN
F 3 "" H 6950 2600 60  0000 C CNN
	1    6950 2600
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR021
U 1 1 530E7769
P 6800 2600
F 0 "#PWR021" H 6800 2600 30  0001 C CNN
F 1 "GND" H 6800 2530 30  0001 C CNN
F 2 "" H 6800 2600 60  0000 C CNN
F 3 "" H 6800 2600 60  0000 C CNN
	1    6800 2600
	-1   0    0    1   
$EndComp
Text Label 6650 2800 0    60   ~ 0
LEDSTACK2
Text Label 6650 2900 0    60   ~ 0
STACKSENSE2
Text Notes 6550 3450 0    80   ~ 0
3.3V input and optional regulator
$Comp
L GND #PWR022
U 1 1 530E9AF9
P 6900 4450
F 0 "#PWR022" H 6900 4450 30  0001 C CNN
F 1 "GND" H 6900 4380 30  0001 C CNN
F 2 "" H 6900 4450 60  0000 C CNN
F 3 "" H 6900 4450 60  0000 C CNN
	1    6900 4450
	0    1    -1   0   
$EndComp
Text Notes 900  4350 0    80   ~ 0
programming and communication
Text Notes 6550 850  0    80   ~ 0
led stacks
Text Notes 900  850  0    80   ~ 0
ATMega 328P microcontroller
Wire Notes Line
	850  5600 5200 5600
Wire Notes Line
	850  4400 5200 4400
Wire Notes Line
	5200 4400 5200 5600
Wire Wire Line
	6900 4450 7050 4450
Wire Notes Line
	6500 3500 10000 3500
Wire Notes Line
	6500 4800 10000 4800
Wire Notes Line
	6500 3500 6500 4800
Wire Wire Line
	7100 2500 7350 2500
Wire Wire Line
	6950 2600 7350 2600
Wire Wire Line
	6650 2900 7350 2900
Wire Wire Line
	6650 2800 7350 2800
Wire Wire Line
	6800 2700 7350 2700
Wire Wire Line
	6800 2600 6800 2700
Wire Wire Line
	7100 1800 7350 1800
Wire Wire Line
	6950 1900 7350 1900
Wire Wire Line
	6650 2200 7350 2200
Wire Wire Line
	6650 2100 7350 2100
Wire Wire Line
	6800 2000 7350 2000
Wire Wire Line
	6800 1900 6800 2000
Wire Wire Line
	7100 1100 7350 1100
Wire Wire Line
	6950 1200 7350 1200
Wire Wire Line
	6650 1500 7350 1500
Wire Wire Line
	6650 1400 7350 1400
Wire Wire Line
	6800 1300 7350 1300
Wire Wire Line
	6800 1200 6800 1300
Wire Wire Line
	5100 2200 4350 2200
Wire Wire Line
	4350 2100 5100 2100
Wire Wire Line
	5100 2000 4350 2000
Wire Wire Line
	5600 1800 5500 1800
Connection ~ 5600 1700
Wire Wire Line
	5500 1700 5700 1700
Wire Wire Line
	4350 1600 5200 1600
Wire Wire Line
	4350 1700 5200 1700
Wire Wire Line
	4350 1800 5200 1800
Connection ~ 8900 4100
Connection ~ 7850 4200
Wire Wire Line
	7850 4300 7850 4200
Wire Wire Line
	7850 4600 7850 4500
Wire Wire Line
	8900 4500 8900 4400
Wire Wire Line
	8950 4100 8850 4100
Wire Wire Line
	7950 4000 7850 4000
Wire Wire Line
	7650 4100 7650 4000
Wire Wire Line
	7950 4100 7650 4100
Wire Wire Line
	7650 4200 7950 4200
Wire Wire Line
	7050 3850 6850 3850
Wire Wire Line
	6900 3950 7050 3950
Wire Wire Line
	3850 5300 3950 5300
Wire Wire Line
	3100 5300 3650 5300
Wire Wire Line
	3100 5100 3950 5100
Wire Wire Line
	3100 5200 3950 5200
Wire Wire Line
	3750 5000 3950 5000
Connection ~ 3850 4800
Wire Wire Line
	3850 4900 3950 4900
Wire Wire Line
	3850 4800 3850 4900
Wire Wire Line
	3750 4800 3950 4800
Wire Wire Line
	4350 2650 5350 2650
Wire Wire Line
	4350 2750 5350 2750
Wire Wire Line
	1500 5100 1000 5100
Wire Wire Line
	1500 5200 1000 5200
Wire Wire Line
	1500 5000 1000 5000
Wire Wire Line
	2400 5100 2900 5100
Wire Wire Line
	2500 5000 2500 4950
Wire Wire Line
	2400 5000 2500 5000
Wire Wire Line
	2500 5200 2400 5200
Wire Wire Line
	2500 5250 2500 5200
Connection ~ 1350 1650
Connection ~ 1650 1650
Connection ~ 1950 1650
Connection ~ 2250 1650
Connection ~ 1950 1850
Connection ~ 1650 1850
Connection ~ 1350 1850
Connection ~ 2250 1550
Wire Wire Line
	2350 1550 2250 1550
Wire Wire Line
	1150 1850 2350 1850
Wire Wire Line
	1150 1650 2350 1650
Wire Wire Line
	2250 1450 2250 1650
Wire Wire Line
	2350 1450 2250 1450
Connection ~ 2250 1850
Connection ~ 2250 1950
Wire Wire Line
	2350 1950 2250 1950
Wire Wire Line
	2250 2150 2250 1850
Wire Wire Line
	2350 2150 2250 2150
Wire Wire Line
	2200 2250 2350 2250
Wire Wire Line
	1900 2250 2000 2250
Wire Wire Line
	1850 1250 2350 1250
Wire Wire Line
	1850 2950 2350 2950
Wire Wire Line
	2350 2850 1850 2850
Wire Wire Line
	1850 2750 2350 2750
Connection ~ 2150 2600
Wire Wire Line
	2250 2600 1600 2600
Wire Wire Line
	2250 2550 2250 2600
Wire Wire Line
	2350 2550 2250 2550
Connection ~ 2150 2400
Wire Wire Line
	2250 2450 2350 2450
Wire Wire Line
	2250 2400 2250 2450
Wire Wire Line
	1600 2400 2250 2400
Connection ~ 1300 2500
Wire Wire Line
	1300 2600 1400 2600
Wire Wire Line
	1300 2400 1400 2400
Wire Wire Line
	1300 2400 1300 2600
Wire Wire Line
	1200 2500 1300 2500
Wire Notes Line
	6500 900  6500 3100
Wire Notes Line
	6500 3100 8200 3100
Wire Notes Line
	8200 3100 8200 900 
Wire Notes Line
	8200 900  6500 900 
Wire Notes Line
	850  900  850  3950
Wire Notes Line
	5950 900  850  900 
$Comp
L PWR_FLAG #FLG023
U 1 1 530EAF0C
P 9600 3800
F 0 "#FLG023" H 9600 3895 30  0001 C CNN
F 1 "PWR_FLAG" H 9600 3980 30  0000 C CNN
F 2 "" H 9600 3800 60  0000 C CNN
F 3 "" H 9600 3800 60  0000 C CNN
	1    9600 3800
	0    1    1    0   
$EndComp
$Comp
L PWR_FLAG #FLG024
U 1 1 530EAF4D
P 9600 4050
F 0 "#FLG024" H 9600 4145 30  0001 C CNN
F 1 "PWR_FLAG" H 9600 4230 30  0000 C CNN
F 2 "" H 9600 4050 60  0000 C CNN
F 3 "" H 9600 4050 60  0000 C CNN
	1    9600 4050
	0    1    1    0   
$EndComp
Text Label 9350 3800 0    60   ~ 0
VIN
Wire Wire Line
	9350 3800 9600 3800
$Comp
L GND #PWR025
U 1 1 530EB006
P 9400 4050
F 0 "#PWR025" H 9400 4050 30  0001 C CNN
F 1 "GND" H 9400 3980 30  0001 C CNN
F 2 "" H 9400 4050 60  0000 C CNN
F 3 "" H 9400 4050 60  0000 C CNN
	1    9400 4050
	0    1    1    0   
$EndComp
Wire Wire Line
	9400 4050 9600 4050
Wire Notes Line
	10000 4800 10000 3500
$Comp
L C C3
U 1 1 5310D0FE
P 1500 2600
F 0 "C3" H 1350 2450 60  0000 C CNN
F 1 "24pF" H 1600 2450 60  0000 C CNN
F 2 "" H 1500 2600 60  0001 C CNN
F 3 "" H 1500 2600 60  0001 C CNN
F 4 "Samsung Electro-Mechanics America, Inc" H 1500 2600 60  0001 C CNN "Manufacturer"
F 5 "CL10C240JB8NCNC" H 1500 2600 60  0001 C CNN "Manuf. Part"
F 6 "Digikey" H 1500 2600 60  0001 C CNN "Distributor"
F 7 "1276-2242-1-ND" H 1500 2600 60  0001 C CNN "Distrib. Part"
F 8 "http://www.digikey.com/product-detail/en/CL10C240JB8NCNC/1276-2242-1-ND/3890328" H 1500 2600 60  0001 C CNN "Distrib. Link"
	1    1500 2600
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR026
U 1 1 5310DE0A
P 6950 4350
F 0 "#PWR026" H 6950 4450 30  0001 C CNN
F 1 "VCC" H 6950 4450 30  0000 C CNN
F 2 "" H 6950 4350 60  0000 C CNN
F 3 "" H 6950 4350 60  0000 C CNN
	1    6950 4350
	0    -1   1    0   
$EndComp
Wire Wire Line
	6950 4350 7050 4350
$Comp
L R R6
U 1 1 5310FE43
P 2000 3350
F 0 "R6" H 1950 3250 60  0000 C CNN
F 1 "1kΩ" H 2150 3250 60  0000 C CNN
F 2 "" H 2000 3350 60  0001 C CNN
F 3 "" H 2000 3350 60  0001 C CNN
F 4 "On hand" H 2000 3350 60  0001 C CNN "Distributor"
	1    2000 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	1700 3150 2350 3150
$Comp
L LED LED1
U 1 1 5310FF26
P 1600 3350
F 0 "LED1" H 1450 3450 60  0000 C CNN
F 1 "RED" H 1750 3450 60  0000 C CNN
F 2 "" H 1600 3350 60  0001 C CNN
F 3 "" H 1600 3350 60  0001 C CNN
F 4 "On hand" H 1600 3350 60  0001 C CNN "Distributor"
	1    1600 3350
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR027
U 1 1 5310FF7B
P 1350 3350
F 0 "#PWR027" H 1350 3450 30  0001 C CNN
F 1 "VCC" H 1350 3450 30  0000 C CNN
F 2 "" H 1350 3350 60  0000 C CNN
F 3 "" H 1350 3350 60  0000 C CNN
	1    1350 3350
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1350 3350 1450 3350
Wire Wire Line
	1750 3350 1850 3350
$Comp
L R R7
U 1 1 531100E8
P 2000 3600
F 0 "R7" H 1950 3500 60  0000 C CNN
F 1 "1kΩ" H 2150 3500 60  0000 C CNN
F 2 "" H 2000 3600 60  0001 C CNN
F 3 "" H 2000 3600 60  0001 C CNN
F 4 "On hand" H 2000 3600 60  0001 C CNN "Distributor"
	1    2000 3600
	1    0    0    -1  
$EndComp
$Comp
L LED LED2
U 1 1 53110110
P 1600 3600
F 0 "LED2" H 1450 3700 60  0000 C CNN
F 1 "RED" H 1750 3700 60  0000 C CNN
F 2 "" H 1600 3600 60  0001 C CNN
F 3 "" H 1600 3600 60  0001 C CNN
F 4 "On hand" H 1600 3600 60  0001 C CNN "Distributor"
	1    1600 3600
	1    0    0    -1  
$EndComp
Wire Notes Line
	850  4400 850  5600
Wire Wire Line
	8900 4100 8900 4200
$Comp
L GND #PWR028
U 1 1 53559FAC
P 2250 3600
F 0 "#PWR028" H 2250 3600 30  0001 C CNN
F 1 "GND" H 2250 3530 30  0001 C CNN
F 2 "" H 2250 3600 60  0000 C CNN
F 3 "" H 2250 3600 60  0000 C CNN
	1    2250 3600
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2250 3600 2150 3600
$Comp
L VCC #PWR029
U 1 1 5355A077
P 1350 3600
F 0 "#PWR029" H 1350 3700 30  0001 C CNN
F 1 "VCC" H 1350 3700 30  0000 C CNN
F 2 "" H 1350 3600 60  0000 C CNN
F 3 "" H 1350 3600 60  0000 C CNN
	1    1350 3600
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1350 3600 1450 3600
Wire Wire Line
	1750 3600 1850 3600
$Comp
L R R1
U 1 1 530E6B36
P 5350 1600
F 0 "R1" H 5250 1900 60  0000 C CNN
F 1 "10kΩ" H 5550 1900 60  0000 C CNN
F 2 "" H 5350 1600 60  0001 C CNN
F 3 "" H 5350 1600 60  0001 C CNN
F 4 "On hand" H 5350 1600 60  0001 C CNN "Distributor"
	1    5350 1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	5600 1800 5600 1600
Wire Wire Line
	5600 1600 5500 1600
Wire Wire Line
	4750 3150 4350 3150
Wire Wire Line
	4750 3250 4350 3250
Text Label 4750 1350 2    60   ~ 0
ADC_C4
Text Label 4750 1250 2    60   ~ 0
POT_0
Wire Wire Line
	4750 1250 4350 1250
Wire Wire Line
	4750 1350 4350 1350
Text Label 4750 1500 2    60   ~ 0
ADC_C3
Wire Wire Line
	4750 1500 4350 1500
Text Label 4850 2500 2    60   ~ 0
WIFI_IRQ
Text Label 5600 2400 2    60   ~ 0
BUTTON_0
Text Label 5600 2300 2    60   ~ 0
BUTTON_1
Wire Wire Line
	4350 2500 4850 2500
Wire Wire Line
	4350 2400 5600 2400
Wire Wire Line
	4350 2300 5600 2300
Wire Wire Line
	1700 3050 2350 3050
$Comp
L C C9
U 1 1 530E333B
P 3750 5300
F 0 "C9" H 3450 5150 60  0000 C CNN
F 1 "0.1uF" H 3700 5150 60  0000 C CNN
F 2 "" H 3750 5300 60  0001 C CNN
F 3 "" H 3750 5300 60  0001 C CNN
F 4 "On hand" H 3750 5300 60  0001 C CNN "Distributor"
	1    3750 5300
	1    0    0    -1  
$EndComp
Wire Notes Line
	850  3950 5950 3950
Wire Notes Line
	5950 3950 5950 900 
$Comp
L 3PIN_MALE P9
U 1 1 5356F83C
P 4900 5200
F 0 "P9" H 4900 5550 60  0000 C CNN
F 1 "WIFI" H 4900 5450 60  0000 C CNN
F 2 "" H 4950 5050 60  0001 C CNN
F 3 "" H 4950 5050 60  0001 C CNN
	1    4900 5200
	1    0    0    -1  
$EndComp
Text Label 1700 3150 0    60   ~ 0
WIFI_EN
Text Label 1700 3050 0    60   ~ 0
WIFI_SS
Text Label 4350 5300 0    60   ~ 0
WIFI_EN
Text Label 4350 5200 0    60   ~ 0
WIFI_SS
Text Label 4350 5100 0    60   ~ 0
WIFI_IRQ
Wire Wire Line
	4350 5100 4800 5100
Wire Wire Line
	4350 5200 4800 5200
Wire Wire Line
	4350 5300 4800 5300
Text Label 4750 3150 2    60   ~ 0
POT_2
Text Label 4750 3250 2    60   ~ 0
POT_1
Text Notes 900  6100 0    80   ~ 0
user input and extra io
$Comp
L 5PIN_MALE P7
U 1 1 5356FC5E
P 1850 6650
F 0 "P7" H 1900 6300 60  0000 C CNN
F 1 "USER-INPUT" H 1700 6200 60  0000 C CNN
F 2 "" H 1900 6550 60  0001 C CNN
F 3 "" H 1900 6550 60  0001 C CNN
	1    1850 6650
	1    0    0    -1  
$EndComp
Text Label 1100 6450 0    60   ~ 0
BUTTON_0
Text Label 1100 6550 0    60   ~ 0
BUTTON_1
Text Label 1250 6850 0    60   ~ 0
POT_2
Text Label 1250 6750 0    60   ~ 0
POT_1
Text Label 1250 6650 0    60   ~ 0
POT_0
Wire Wire Line
	1250 6850 1750 6850
Wire Wire Line
	1750 6750 1250 6750
Wire Wire Line
	1250 6650 1750 6650
Wire Wire Line
	1750 6550 1100 6550
Wire Wire Line
	1100 6450 1750 6450
$Comp
L 2PIN_MALE P8
U 1 1 53570408
P 2850 6700
F 0 "P8" H 2900 6500 60  0000 C CNN
F 1 "EXTRA-IO" H 2750 6400 60  0000 C CNN
F 2 "" H 2800 6500 60  0001 C CNN
F 3 "" H 2800 6500 60  0001 C CNN
	1    2850 6700
	1    0    0    -1  
$EndComp
Text Label 2300 6750 0    60   ~ 0
ADC_C4
Text Label 2300 6650 0    60   ~ 0
ADC_C3
Wire Wire Line
	2750 6750 2300 6750
Wire Wire Line
	2300 6650 2750 6650
Wire Notes Line
	850  6150 850  7250
Wire Notes Line
	850  7250 3300 7250
Wire Notes Line
	3300 7250 3300 6150
Wire Notes Line
	3300 6150 850  6150
$Comp
L 2PIN_MALE P10
U 1 1 535707D7
P 7150 4400
F 0 "P10" H 7350 4400 60  0000 C CNN
F 1 "VCC" H 7150 4200 60  0000 C CNN
F 2 "" H 7100 4200 60  0001 C CNN
F 3 "" H 7100 4200 60  0001 C CNN
	1    7150 4400
	1    0    0    -1  
$EndComp
Wire Wire Line
	2150 3350 2250 3350
Wire Wire Line
	2250 3350 2250 3250
Wire Wire Line
	2250 3250 2350 3250
$EndSCHEMATC