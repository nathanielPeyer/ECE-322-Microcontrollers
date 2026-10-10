; ECE 322 - Homework 3
; Author: Nathaniel Peyer
; ATtiny13A
; Assumed clock: 1 MHz
; Output: PB0
;
; Sequence:
; ON  1.0 ms
; OFF 0.5 ms
; ON  0.7 ms
; OFF 0.3 ms
; Repeat

.include "tn13a.inc"

.org 0x0000
    rjmp RESET

RESET:
    ; Configure PB0 as output
    sbi DDRB, 0

    ; Configure Timer0 for CTC mode
    ldi r16, (1<<WGM01)
    out TCCR0A, r16

    ; Set compare value for 100 us
    ldi r16, 99
    out OCR0A, r16

    ; Start Timer0, no prescaler
    ldi r16, (1<<CS00)
    out TCCR0B, r16

MAIN:
    ; PB0 ON for 1.0 ms
    sbi PORTB, 0
    ldi r18, 10
    rcall DELAY

    ; PB0 OFF for 0.5 ms
    cbi PORTB, 0
    ldi r18, 5
    rcall DELAY

    ; PB0 ON for 0.7 ms
    sbi PORTB, 0
    ldi r18, 7
    rcall DELAY

    ; PB0 OFF for 0.3 ms
    cbi PORTB, 0
    ldi r18, 3
    rcall DELAY

    ; Repeat forever
    rjmp MAIN


;--------------------------------
; Delay subroutine
; Each iteration waits for
; approximately 100 us.
;
; Input: r18 = number of intervals
;--------------------------------

DELAY:
    ; Clear Timer0 compare flag
    ldi r17, (1<<OCF0A)

DELAY_LOOP:
    out TIFR0, r17

WAIT:
    in r16, TIFR0
    sbrs r16, OCF0A
    rjmp WAIT

    dec r18
    brne DELAY_LOOP

    ret