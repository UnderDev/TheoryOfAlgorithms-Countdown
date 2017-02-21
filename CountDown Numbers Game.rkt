#lang racket

;() Empty List

;--------------------------------------> Inital Setup <--------------------------------------------
; Defining the List of Small Numbers
(define sNums (list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10))

; Defining the List of Large Numbers
(define lNums (list 25 50 75 100))

; Defining the List of Large Numbers
(define operators (list - + / *))


; Defining the List of Choosen Numbers
(define choosenNums (list 5 25))

;Random Number Function Takes in Two Numbers and returns a number in that range
(define (rnd-num a b)
  (random a b))
;OR
;(rnd-num 101 999)

; Defining The Target Number
(define targetNum (rnd-num 101 999))


;--------------------------------------> Print out the lists <--------------------------------------------
"Small Number Lists"
sNums

"Large Numbers List"
lNums

"Operators List"
operators

"Choosen Numbers List"
choosenNums

"TargetNum:"
targetNum










; oper is the operation to apply to the function elements.
; id is the identity for oper (when used with oper nothing changes).
(define (f oper id l)
  (if (null? l)
      id
      (oper (car l) (f oper id (cdr l)))))

; Now define fsum, which does the same thing as sum above, but define it using f.
; Note that f takes three arguments, and all fsum does is hard-code two of those.
(define (fsum l) (f + 0 l))
(fsum (list 1 2 3 4 5))