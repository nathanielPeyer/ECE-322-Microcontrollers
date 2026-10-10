; ECE 322 - Homework 4
; Author: Nate Peyer
; Date: 06 September, 2026

.include "tn13def.inc"

.org 0x0000
    rjmp RESET

RESET:
    ; Set PB0 as output
    sbi DDRB, PB0

    ; Set PB1 as input
    cbi DDRB, PB1

    ; Enable pull-up resistor on PB1
    sbi PORTB, PB1

LOOP:
    ; Check PB1
    sbic PINB, PB1
    rjmp LED_ON

LED_OFF:
    cbi PORTB, PB0
    rjmp LOOP

LED_ON:
    sbi PORTB, PB0
    rjmp LOOP