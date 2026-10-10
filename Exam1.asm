;*************************************************************************************************;
; ECE 322 Take Home Exam 1                                                                        ;
; Author: Nathaniel Peyer                                                                         ;
; Date: 10 October, 2026                                                                          ;
;                                                                                                 ;
; I have never given or received nor have I tolerated others use of unauthorized aid.             ;
; Nathaniel Peyer                                                                                 ;
; Pattern:                                                                                        ;
; 1 0 0 0                                                                                         ;
; 0 1 0 0                                                                                         ;
; 0 0 1 0                                                                                         ;
; 0 0 0 1                                                                                         ;
; 0 0 1 0                                                                                         ;
; 0 1 0 0                                                                                         ;
; 1 0 0 0                                                                                         ;
; Delay: 200ms                                                                                    ;
;*************************************************************************************************;

; Includes
.include "tn13a.inc"

.org 0x0000
  rjmp RESET


RESET:
  ; Configure the stack pointer
  ldi r16, low(RAMEND)
  out SPL, r16 

  ; Configure the output pins.
  ldi r16, 0b00001111
  out DDRB, r16

MAIN:
  ; 1 0 0 0 
  ldi r16, 0b00000001
  out PORTB, r16
  rcall DELAY

  ; 0 1 0 0
  ldi r16, 0b00000010
  out PORTB, r16
  rcall DELAY

  ; 0 0 1 0
  ldi r16, 0b00000100
  out PORTB, r16
  rcall DELAY

  ; 0 0 0 1
  ldi r16, 0b00001000
  out PORTB, r16
  rcall DELAY

  ; 0 0 1 0
  ldi r16, 0b00000100
  out PORTB, r16
  rcall DELAY

  ; 0 0 1 0
  ldi r16, 0b00000100
  out PORTB, r16
  rcall DELAY
  
  ; 0 1 0 0
  ldi r16, 0b00000010
  out PORTB, r16
  rcall DELAY

  ; 1 0 0 0 
  ldi r16, 0b00000001
  out PORTB, r16
  rcall DELAY

  ; Reset the program to repeat the sequence
  rjmp MAIN

; Delay subroutine
; Each iteration waits for approximately 200 ms.
DELAY:
  ; Load the delay count into r18
  ldi r18, 4

DELAY_OUTER:
  ldi r19, 250

DELAY_MIDDLE:
  ldi r29, 250

DELAY_INNER:
  dec r20
  brne DELAY_INNER

  dec r19
  brne DELAY_MIDDLE

  dec r18
  brne DELAY_OUTER

  ret
