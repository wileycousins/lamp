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
LIBS:lamp-pcb-cache
EELAYER 24 0
EELAYER END
$Descr A 11000 8500
encoding utf-8
Sheet 1 1
Title "lamp pcb"
Date ""
Rev "0.1"
Comp "copyright 2014 by Wiley Cousins"
Comment1 "shared under the terms of the Attribution-ShareAlike 4.0 license"
Comment2 "github.com/wileycousins/lamp"
Comment3 "open source hardware"
Comment4 ""
$EndDescr
$Comp
L ATMEGA328P_TQFP IC?
U 1 1 530E2A6B
P 3550 2600
F 0 "IC?" H 2850 3750 60  0000 C CNN
F 1 "ATMEGA328P" H 3900 1400 60  0000 C CNN
F 2 "" H 3550 2600 60  0000 C CNN
F 3 "" H 3550 2600 60  0000 C CNN
	1    3550 2600
	1    0    0    -1  
$EndComp
$Comp
L AVR_ISP P?
U 1 1 530E2A7F
P 3650 4550
F 0 "P?" H 3450 4800 60  0000 C CNN
F 1 "AVR_ISP" H 3700 4300 60  0000 C CNN
F 2 "" H 3650 4550 60  0001 C CNN
F 3 "" H 3650 4550 60  0001 C CNN
	1    3650 4550
	1    0    0    -1  
$EndComp
$Comp
L 6PIN_HEADER P?
U 1 1 530E2A93
P 3650 5600
F 0 "P?" H 3750 6100 60  0000 C CNN
F 1 "SERIAL" H 3800 6000 60  0000 C CNN
F 2 "" H 3700 5600 60  0000 C CNN
F 3 "" H 3700 5600 60  0000 C CNN
	1    3650 5600
	1    0    0    -1  
$EndComp
$Comp
L CRYSTAL Y?
U 1 1 530E2AA7
P 2350 2850
F 0 "Y?" V 2400 3050 60  0000 C CNN
F 1 "16MHz" V 2300 3150 60  0000 C CNN
F 2 "" H 2350 2850 60  0000 C CNN
F 3 "" H 2350 2850 60  0000 C CNN
	1    2350 2850
	0    -1   -1   0   
$EndComp
$Comp
L C C?
U 1 1 530E2AD4
P 1700 2950
F 0 "C?" H 1550 2800 60  0000 C CNN
F 1 "20pF" H 1800 2800 60  0000 C CNN
F 2 "" H 1700 2950 60  0001 C CNN
F 3 "" H 1700 2950 60  0001 C CNN
	1    1700 2950
	1    0    0    -1  
$EndComp
$Comp
L C C?
U 1 1 530E2B0B
P 1700 2750
F 0 "C?" H 1550 2900 60  0000 C CNN
F 1 "20pF" H 1800 2900 60  0000 C CNN
F 2 "" H 1700 2750 60  0001 C CNN
F 3 "" H 1700 2750 60  0001 C CNN
	1    1700 2750
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 530E2B38
P 1400 2850
F 0 "#PWR?" H 1400 2850 30  0001 C CNN
F 1 "GND" H 1400 2780 30  0001 C CNN
F 2 "" H 1400 2850 60  0000 C CNN
F 3 "" H 1400 2850 60  0000 C CNN
	1    1400 2850
	0    1    1    0   
$EndComp
Text Label 2050 3100 0    60   ~ 0
AVR_SCK
Text Label 2050 3200 0    60   ~ 0
AVR_MISO
Text Label 2050 3300 0    60   ~ 0
AVR_MOSI
Wire Wire Line
	1400 2850 1500 2850
Wire Wire Line
	1500 2750 1500 2950
Wire Wire Line
	1500 2750 1600 2750
Wire Wire Line
	1500 2950 1600 2950
Connection ~ 1500 2850
Wire Wire Line
	1800 2750 2450 2750
Wire Wire Line
	2450 2750 2450 2800
Wire Wire Line
	2450 2800 2550 2800
Connection ~ 2350 2750
Wire Wire Line
	2550 2900 2450 2900
Wire Wire Line
	2450 2900 2450 2950
Wire Wire Line
	2450 2950 1800 2950
Connection ~ 2350 2950
Wire Wire Line
	2050 3100 2550 3100
Wire Wire Line
	2550 3200 2050 3200
Wire Wire Line
	2050 3300 2550 3300
Text Label 2050 1600 0    60   ~ 0
AVR_RST
Wire Wire Line
	2050 1600 2550 1600
$Comp
L C C?
U 1 1 530E2C15
P 2300 2600
F 0 "C?" H 2150 2800 60  0000 C CNN
F 1 "0.1uF" H 2150 2700 60  0000 C CNN
F 2 "" H 2300 2600 60  0001 C CNN
F 3 "" H 2300 2600 60  0001 C CNN
	1    2300 2600
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 530E2C3A
P 2100 2600
F 0 "#PWR?" H 2100 2600 30  0001 C CNN
F 1 "GND" H 2100 2530 30  0001 C CNN
F 2 "" H 2100 2600 60  0000 C CNN
F 3 "" H 2100 2600 60  0000 C CNN
	1    2100 2600
	0    1    1    0   
$EndComp
Wire Wire Line
	2100 2600 2200 2600
Wire Wire Line
	2400 2600 2550 2600
Wire Wire Line
	2550 2500 2450 2500
Wire Wire Line
	2450 2500 2450 2200
Wire Wire Line
	2550 2300 2450 2300
Connection ~ 2450 2300
$Comp
L VCC #PWR?
U 1 1 530E2CEA
P 1350 2200
F 0 "#PWR?" H 1350 2300 30  0001 C CNN
F 1 "VCC" H 1350 2300 30  0000 C CNN
F 2 "" H 1350 2200 60  0000 C CNN
F 3 "" H 1350 2200 60  0000 C CNN
	1    1350 2200
	0    -1   -1   0   
$EndComp
Connection ~ 2450 2200
Wire Wire Line
	2550 1800 2450 1800
Wire Wire Line
	2450 1800 2450 2000
Wire Wire Line
	1350 2000 2550 2000
$Comp
L GND #PWR?
U 1 1 530E2D76
P 1350 2000
F 0 "#PWR?" H 1350 2000 30  0001 C CNN
F 1 "GND" H 1350 1930 30  0001 C CNN
F 2 "" H 1350 2000 60  0000 C CNN
F 3 "" H 1350 2000 60  0000 C CNN
	1    1350 2000
	0    1    1    0   
$EndComp
Wire Wire Line
	1350 2200 2550 2200
$Comp
L C C?
U 1 1 530E2DE7
P 1550 2100
F 0 "C?" V 1850 2100 60  0000 C CNN
F 1 "0.1uF" V 1750 2100 60  0000 C CNN
F 2 "" H 1550 2100 60  0001 C CNN
F 3 "" H 1550 2100 60  0001 C CNN
	1    1550 2100
	0    -1   -1   0   
$EndComp
$Comp
L C C?
U 1 1 530E2DFB
P 1850 2100
F 0 "C?" V 2150 2100 60  0000 C CNN
F 1 "0.1uF" V 2050 2100 60  0000 C CNN
F 2 "" H 1850 2100 60  0001 C CNN
F 3 "" H 1850 2100 60  0001 C CNN
	1    1850 2100
	0    -1   -1   0   
$EndComp
$Comp
L C C?
U 1 1 530E2E0F
P 2150 2100
F 0 "C?" V 2450 2100 60  0000 C CNN
F 1 "0.1uF" V 2350 2100 60  0000 C CNN
F 2 "" H 2150 2100 60  0001 C CNN
F 3 "" H 2150 2100 60  0001 C CNN
	1    2150 2100
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2550 1900 2450 1900
Connection ~ 2450 1900
Connection ~ 1550 2200
Connection ~ 1850 2200
Connection ~ 2150 2200
Connection ~ 2450 2000
Connection ~ 2150 2000
Connection ~ 1850 2000
Connection ~ 1550 2000
Text Label 2700 4650 0    60   ~ 0
AVR_RST
Text Label 2700 4550 0    60   ~ 0
AVR_SCK
Text Label 2700 4450 0    60   ~ 0
AVR_MISO
Text Label 4600 4550 2    60   ~ 0
AVR_MOSI
$Comp
L VCC #PWR?
U 1 1 530E3068
P 4200 4400
F 0 "#PWR?" H 4200 4500 30  0001 C CNN
F 1 "VCC" H 4200 4500 30  0000 C CNN
F 2 "" H 4200 4400 60  0000 C CNN
F 3 "" H 4200 4400 60  0000 C CNN
	1    4200 4400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 530E307C
P 4200 4700
F 0 "#PWR?" H 4200 4700 30  0001 C CNN
F 1 "GND" H 4200 4630 30  0001 C CNN
F 2 "" H 4200 4700 60  0000 C CNN
F 3 "" H 4200 4700 60  0000 C CNN
	1    4200 4700
	1    0    0    -1  
$EndComp
Wire Wire Line
	4200 4700 4200 4650
Wire Wire Line
	4200 4650 4100 4650
Wire Wire Line
	4100 4450 4200 4450
Wire Wire Line
	4200 4450 4200 4400
Wire Wire Line
	4100 4550 4600 4550
Wire Wire Line
	3200 4450 2700 4450
Wire Wire Line
	3200 4650 2700 4650
Wire Wire Line
	3200 4550 2700 4550
Text Label 5050 3000 2    60   ~ 0
USART_TX
Text Label 5050 3100 2    60   ~ 0
USART_RX
Wire Wire Line
	5050 3100 4550 3100
Wire Wire Line
	4550 3000 5050 3000
$Comp
L GND #PWR?
U 1 1 530E3278
P 3350 5350
F 0 "#PWR?" H 3350 5350 30  0001 C CNN
F 1 "GND" H 3350 5280 30  0001 C CNN
F 2 "" H 3350 5350 60  0000 C CNN
F 3 "" H 3350 5350 60  0000 C CNN
	1    3350 5350
	0    1    1    0   
$EndComp
Wire Wire Line
	3350 5350 3550 5350
Wire Wire Line
	3450 5350 3450 5450
Wire Wire Line
	3450 5450 3550 5450
Connection ~ 3450 5350
$Comp
L VCC #PWR?
U 1 1 530E32F0
P 3350 5550
F 0 "#PWR?" H 3350 5650 30  0001 C CNN
F 1 "VCC" H 3350 5650 30  0000 C CNN
F 2 "" H 3350 5550 60  0000 C CNN
F 3 "" H 3350 5550 60  0000 C CNN
	1    3350 5550
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3350 5550 3550 5550
Text Label 2700 5650 0    60   ~ 0
USART_RX
Text Label 2700 5750 0    60   ~ 0
USART_TX
$Comp
L C C?
U 1 1 530E333B
P 3350 5850
F 0 "C?" H 3250 5700 60  0000 C CNN
F 1 "0.1uF" H 3500 5700 60  0000 C CNN
F 2 "" H 3350 5850 60  0001 C CNN
F 3 "" H 3350 5850 60  0001 C CNN
	1    3350 5850
	1    0    0    -1  
$EndComp
Wire Wire Line
	2700 5750 3550 5750
Wire Wire Line
	2700 5650 3550 5650
Text Label 2700 5850 0    60   ~ 0
AVR_RST
Wire Wire Line
	2700 5850 3250 5850
Wire Wire Line
	3450 5850 3550 5850
$Comp
L TLC5971_SOP IC?
U 1 1 530E3538
P 8150 2050
F 0 "IC?" H 8050 2900 60  0000 C CNN
F 1 "TLC5971" H 8150 2800 60  0000 C CNN
F 2 "" H 8150 2050 60  0001 C CNN
F 3 "" H 8150 2050 60  0001 C CNN
F 4 "TI" H 7850 1300 60  0001 C CNN "Manufacturer"
F 5 "TLC5971PWP" H 8250 1300 60  0001 C CNN "Part"
	1    8150 2050
	1    0    0    -1  
$EndComp
$Comp
L 2PIN_MALE P?
U 1 1 530E35EB
P 3700 6700
F 0 "P?" H 3650 6900 60  0000 C CNN
F 1 "DCIN" H 3700 6500 60  0000 C CNN
F 2 "" H 3650 6500 60  0000 C CNN
F 3 "" H 3650 6500 60  0000 C CNN
	1    3700 6700
	1    0    0    -1  
$EndComp
Text Label 3400 6650 0    60   ~ 0
VIN
$Comp
L GND #PWR?
U 1 1 530E3694
P 3450 6750
F 0 "#PWR?" H 3450 6750 30  0001 C CNN
F 1 "GND" H 3450 6680 30  0001 C CNN
F 2 "" H 3450 6750 60  0000 C CNN
F 3 "" H 3450 6750 60  0000 C CNN
	1    3450 6750
	0    1    1    0   
$EndComp
Wire Wire Line
	3450 6750 3600 6750
Wire Wire Line
	3600 6650 3400 6650
$Comp
L C C?
U 1 1 530E374A
P 7450 1800
F 0 "C?" V 7550 2000 60  0000 C CNN
F 1 "0.1uF" V 7450 2050 60  0000 C CNN
F 2 "" H 7450 1800 60  0001 C CNN
F 3 "" H 7450 1800 60  0001 C CNN
	1    7450 1800
	0    -1   -1   0   
$EndComp
$Comp
L VCC #PWR?
U 1 1 530E378B
P 7350 1500
F 0 "#PWR?" H 7350 1600 30  0001 C CNN
F 1 "VCC" H 7350 1600 30  0000 C CNN
F 2 "" H 7350 1500 60  0000 C CNN
F 3 "" H 7350 1500 60  0000 C CNN
	1    7350 1500
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7350 1500 7650 1500
Wire Wire Line
	7450 1500 7450 1700
Connection ~ 7450 1500
Wire Wire Line
	7450 1700 7650 1700
Wire Wire Line
	7200 1900 7650 1900
$Comp
L R R?
U 1 1 530E38F8
P 7400 2100
F 0 "R?" H 7100 2000 60  0000 C CNN
F 1 "2.2kΩ" H 7350 2000 60  0000 C CNN
F 2 "" H 7400 2100 60  0001 C CNN
F 3 "" H 7400 2100 60  0001 C CNN
	1    7400 2100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 530E395C
P 7100 2000
F 0 "#PWR?" H 7100 2000 30  0001 C CNN
F 1 "GND" H 7100 1930 30  0001 C CNN
F 2 "" H 7100 2000 60  0000 C CNN
F 3 "" H 7100 2000 60  0000 C CNN
	1    7100 2000
	0    1    1    0   
$EndComp
Wire Wire Line
	7100 2000 7200 2000
Wire Wire Line
	7200 1900 7200 2100
Wire Wire Line
	7200 2100 7250 2100
Connection ~ 7200 2000
Connection ~ 7450 1900
Wire Wire Line
	7550 2100 7650 2100
NoConn ~ 7650 2600
NoConn ~ 7650 2500
Text Label 7050 2400 0    60   ~ 0
LED_MOSI
Text Label 7050 2500 0    60   ~ 0
LED_SCK
Wire Wire Line
	7050 2400 7500 2400
Wire Wire Line
	7500 2400 7500 2300
Wire Wire Line
	7500 2300 7650 2300
Wire Wire Line
	7650 2400 7550 2400
Wire Wire Line
	7550 2400 7550 2500
Wire Wire Line
	7550 2500 7050 2500
$Comp
L GND #PWR?
U 1 1 530E3B27
P 8150 2950
F 0 "#PWR?" H 8150 2950 30  0001 C CNN
F 1 "GND" H 8150 2880 30  0001 C CNN
F 2 "" H 8150 2950 60  0000 C CNN
F 3 "" H 8150 2950 60  0000 C CNN
	1    8150 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	8150 2950 8150 2850
Text Label 9100 1500 2    60   ~ 0
LED_R0
Text Label 9100 1600 2    60   ~ 0
LED_G0
Text Label 9100 1700 2    60   ~ 0
LED_B0
Text Label 9100 1800 2    60   ~ 0
LED_R1
Text Label 9100 1900 2    60   ~ 0
LED_G1
Text Label 9100 2000 2    60   ~ 0
LED_B1
Text Label 9100 2100 2    60   ~ 0
LED_R2
Text Label 9100 2200 2    60   ~ 0
LED_G2
Text Label 9100 2300 2    60   ~ 0
LED_B2
Text Label 9100 2400 2    60   ~ 0
LED_R3
Text Label 9100 2500 2    60   ~ 0
LED_G3
Text Label 9100 2600 2    60   ~ 0
LED_B3
Wire Wire Line
	9100 1500 8650 1500
Wire Wire Line
	8650 1600 9100 1600
Wire Wire Line
	9100 1700 8650 1700
Wire Wire Line
	8650 1800 9100 1800
Wire Wire Line
	9100 1900 8650 1900
Wire Wire Line
	8650 2000 9100 2000
Wire Wire Line
	9100 2100 8650 2100
Wire Wire Line
	8650 2200 9100 2200
Wire Wire Line
	9100 2300 8650 2300
Wire Wire Line
	8650 2400 9100 2400
Wire Wire Line
	9100 2500 8650 2500
Wire Wire Line
	8650 2600 9100 2600
$EndSCHEMATC
